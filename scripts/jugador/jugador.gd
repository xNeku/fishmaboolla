class_name Jugador
extends Node2D
## Lógica del marinero. La posición es la de los PIES.
## No lee input ni dibuja: recibe órdenes (orden_*) y expone estado.

signal salto_iniciado
signal aterrizado
signal dash_iniciado(direccion: int)
signal dash_terminado
## Una bola ha tocado al marinero y le ha quitado una vida (no se emite con i-frames).
signal tocado
## El marinero se ha quedado sin vidas. Se emite una sola vez.
signal murio
## El marinero dispara. `origen` es la punta de arriba del cuerpo.
signal disparado(origen: Vector2)

@export var config: JugadorConfig
## Límites de la sala. El borde inferior es el suelo.
@export var limites: Rect2 = Rect2(80.0, 60.0, 1760.0, 960.0)

var velocidad: Vector2 = Vector2.ZERO
var direccion_mirada: int = 1
var en_suelo: bool = true
var dashing: bool = false

var vidas: int = 0
var muerto: bool = false
## Segundos que quedan de invulnerabilidad tras un toque.
var invulnerabilidad_restante: float = 0.0

var invulnerable: bool:
	get:
		return (dashing and config.dash_invulnerable) or invulnerabilidad_restante > 0.0

## Segundos que faltan para poder volver a hacer dash.
var cooldown_dash_restante: float = 0.0
## Segundos que faltan para poder volver a disparar.
var cooldown_disparo_restante: float = 0.0

var _intencion_mover: float = 0.0
var _salto_pedido: bool = false
var _dash_tiempo: float = 0.0
var _dash_dir: int = 1


func _ready() -> void:
	vidas = config.vidas_maximas


func orden_mover(direccion: float) -> void:
	_intencion_mover = 0.0 if muerto else clampf(direccion, -1.0, 1.0)


func orden_saltar() -> void:
	if not muerto:
		_salto_pedido = true


## Devuelve true si el disparo salió (false si sigue el cooldown o está muerto).
func orden_disparar() -> bool:
	if muerto or cooldown_disparo_restante > 0.0:
		return false
	cooldown_disparo_restante = config.cooldown_disparo
	disparado.emit(Vector2(position.x, position.y - config.alto))
	return true


## Devuelve true si el dash arrancó.
func orden_dash(direccion: int) -> bool:
	if muerto or dashing or cooldown_dash_restante > 0.0 or direccion == 0:
		return false
	dashing = true
	_dash_dir = signi(direccion)
	direccion_mirada = _dash_dir
	_dash_tiempo = config.dash_duracion
	dash_iniciado.emit(_dash_dir)
	return true


## ¿Solapa el círculo con el cuerpo del marinero (rectángulo con origen en los pies)?
func toca_circulo(centro: Vector2, radio: float) -> bool:
	var cuerpo := Rect2(position.x - config.ancho * 0.5, position.y - config.alto, config.ancho, config.alto)
	var cercano := Vector2(
			clampf(centro.x, cuerpo.position.x, cuerpo.end.x),
			clampf(centro.y, cuerpo.position.y, cuerpo.end.y))
	return cercano.distance_squared_to(centro) <= radio * radio


## Devuelve true si el toque cuenta (false durante los i-frames).
func recibir_toque() -> bool:
	if muerto or invulnerable:
		return false
	vidas -= 1
	tocado.emit()
	if vidas <= 0:
		muerto = true
		murio.emit()
	else:
		invulnerabilidad_restante = config.invulnerabilidad_tras_toque
	return true


func _physics_process(delta: float) -> void:
	invulnerabilidad_restante = maxf(0.0, invulnerabilidad_restante - delta)
	cooldown_dash_restante = maxf(0.0, cooldown_dash_restante - delta)
	cooldown_disparo_restante = maxf(0.0, cooldown_disparo_restante - delta)

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
