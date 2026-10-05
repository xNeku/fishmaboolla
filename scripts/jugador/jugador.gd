class_name Jugador
extends Node2D
## Lógica del marinero. La posición es la de los PIES.
## No lee input ni dibuja: recibe órdenes (orden_*) y expone estado.

signal salto_iniciado
signal aterrizado
signal dash_iniciado(direccion: int)
signal dash_terminado

@export var config: JugadorConfig
## Límites de la sala. El borde inferior es el suelo.
@export var limites: Rect2 = Rect2(0.0, 0.0, 1280.0, 640.0)

var velocidad: Vector2 = Vector2.ZERO
var direccion_mirada: int = 1
var en_suelo: bool = true
var dashing: bool = false

var invulnerable: bool:
	get:
		return dashing and config.dash_invulnerable

## Segundos que faltan para poder volver a hacer dash.
var cooldown_dash_restante: float = 0.0

var _intencion_mover: float = 0.0
var _salto_pedido: bool = false
var _dash_tiempo: float = 0.0
var _dash_dir: int = 1


func orden_mover(direccion: float) -> void:
	_intencion_mover = clampf(direccion, -1.0, 1.0)


func orden_saltar() -> void:
	_salto_pedido = true


## Devuelve true si el dash arrancó.
func orden_dash(direccion: int) -> bool:
	if dashing or cooldown_dash_restante > 0.0 or direccion == 0:
		return false
	dashing = true
	_dash_dir = signi(direccion)
	direccion_mirada = _dash_dir
	_dash_tiempo = config.dash_duracion
	dash_iniciado.emit(_dash_dir)
	return true


func _physics_process(delta: float) -> void:
	cooldown_dash_restante = maxf(0.0, cooldown_dash_restante - delta)

	if dashing:
		# El dash anula la gravedad y el movimiento vertical; velocidad.y se conserva.
		# El último paso se recorta al tiempo restante: la distancia no depende del framerate.
		var paso: float = minf(delta, _dash_tiempo)
		_dash_tiempo -= delta
		position.x += _dash_dir * config.dash_velocidad * paso
		if _dash_tiempo <= 0.0:
			dashing = false
			cooldown_dash_restante = config.dash_cooldown
			dash_terminado.emit()
	else:
		velocidad.x = _intencion_mover * config.velocidad_lateral
		if _intencion_mover != 0.0:
			direccion_mirada = signi(_intencion_mover)
		if _salto_pedido and en_suelo:
			velocidad.y = -config.velocidad_salto
			en_suelo = false
			salto_iniciado.emit()
		velocidad.y += config.gravedad * delta
		position += velocidad * delta

	_salto_pedido = false
	_aplicar_limites()


func _aplicar_limites() -> void:
	var mitad: float = config.ancho * 0.5
	position.x = clampf(position.x, limites.position.x + mitad, limites.end.x - mitad)
	if position.y >= limites.end.y:
		position.y = limites.end.y
		if velocidad.y > 0.0:
			velocidad.y = 0.0
		if not en_suelo:
			en_suelo = true
			aterrizado.emit()
	elif position.y < limites.position.y + config.alto:
		position.y = limites.position.y + config.alto
		velocidad.y = maxf(velocidad.y, 0.0)
