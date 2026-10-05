class_name Bola
extends Node2D
## Lógica de una bola con física Pang. Solo rebota contra los límites de la sala.
## No dibuja (eso es BolaVisual). Los límites y la gravedad se los da quien la crea.

const RUTA_ESCENA: String = "res://scenes/bola.tscn"

signal impactada(bola: Bola)

@export var datos: BolaDatos
## Sentido horizontal inicial.
@export_enum("Izquierda:-1", "Derecha:1") var direccion_inicial: int = 1

## Impulso vertical inicial hacia arriba. Lo fija la división.
var impulso_inicial: float = 0.0
var gravedad: float = 1500.0
var limites: Rect2 = Rect2()
var velocidad: Vector2 = Vector2.ZERO

var radio: float:
	get:
		return datos.radio

var esta_rota: bool:
	get:
		return _rota

var _dir: int = 1
var _rota: bool = false


func _ready() -> void:
	add_to_group("bolas")
	_dir = -1 if direccion_inicial < 0 else 1
	velocidad = Vector2(_dir * datos.velocidad_horizontal, -impulso_inicial)


func _physics_process(delta: float) -> void:
	velocidad.x = _dir * datos.velocidad_horizontal
	# Parábola exacta (Verlet): la altura de rebote sale como la configurada.
	position.x += velocidad.x * delta
	position.y += velocidad.y * delta + 0.5 * gravedad * delta * delta
	velocidad.y += gravedad * delta
	_rebotar()


func _rebotar() -> void:
	var r: float = datos.radio
	if position.x - r < limites.position.x:
		position.x = limites.position.x + r
		_dir = 1
	elif position.x + r > limites.end.x:
		position.x = limites.end.x - r
		_dir = -1
	if position.y + r >= limites.end.y:
		position.y = limites.end.y - r
		velocidad.y = -sqrt(2.0 * gravedad * datos.altura_rebote)
	elif position.y - r <= limites.position.y:
		position.y = limites.position.y + r
		velocidad.y = maxf(velocidad.y, 0.0)


## La bola se rompe: se divide en dos del tier siguiente (salen en sentidos opuestos)
## o desaparece si es la más pequeña.
func recibir_impacto() -> void:
	if _rota:
		return
	_rota = true
	remove_from_group("bolas")
	impactada.emit(self)
	if datos.siguiente != null:
		var escena: PackedScene = load(RUTA_ESCENA)
		for sentido: int in [-1, 1]:
			var hija: Bola = escena.instantiate() as Bola
			hija.datos = datos.siguiente
			hija.direccion_inicial = sentido
			hija.impulso_inicial = datos.siguiente.impulso_division
			hija.gravedad = gravedad
			hija.limites = limites
			hija.position = position
			get_parent().add_child(hija)
	queue_free()
