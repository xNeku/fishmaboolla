class_name JugadorVisual
extends Node2D
## Programmer art del marinero (chubasquero amarillo). Solo dibuja; lee el estado del Jugador.
## Se sustituirá por el arte a mano del humano.

const AMARILLO: Color = Color(0.98, 0.8, 0.1)
const AMARILLO_OSCURO: Color = Color(0.7, 0.5, 0.05)
const PIEL: Color = Color(0.93, 0.74, 0.58)

@export var jugador: Jugador

var _squash: float = 0.0


func _ready() -> void:
	jugador.aterrizado.connect(func() -> void: _squash = 1.0)
	jugador.salto_iniciado.connect(func() -> void: _squash = -1.0)


func _process(delta: float) -> void:
	_squash = move_toward(_squash, 0.0, delta * 8.0)
	queue_redraw()


func _draw() -> void:
	var w: float = jugador.config.ancho
	var h: float = jugador.config.alto
	var sx: float = 1.0
	var sy: float = 1.0
	if jugador.dashing:
		sx = 1.35
		sy = 0.8
	else:
		sx = 1.0 + _squash * 0.15
		sy = 1.0 - _squash * 0.15
	var alpha: float = 1.0
	if jugador.invulnerable:
		alpha = 0.5 + 0.3 * sin(Time.get_ticks_msec() * 0.05)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2(sx, sy))

	var cuerpo_h: float = h * 0.68
	var cuerpo := Rect2(-w * 0.5, -cuerpo_h, w, cuerpo_h)
	draw_rect(cuerpo, Color(AMARILLO, alpha))
	draw_rect(cuerpo, Color(AMARILLO_OSCURO, alpha), false, 3.0)

	var cabeza_r: float = h * 0.15
	var cabeza := Vector2(0.0, -cuerpo_h - cabeza_r * 0.6)
	draw_circle(cabeza, cabeza_r, Color(PIEL, alpha))
	# Capucha
	draw_arc(cabeza, cabeza_r + 3.0, PI, TAU, 16, Color(AMARILLO, alpha), 6.0)
	# Ojo hacia donde mira
	draw_circle(cabeza + Vector2(jugador.direccion_mirada * cabeza_r * 0.45, -2.0), 2.5, Color(0, 0, 0, alpha))
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
