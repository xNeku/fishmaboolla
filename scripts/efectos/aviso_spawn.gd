class_name AvisoSpawn
extends Node2D
## Marca temporal que avisa de dónde va a salir una bola. Solo visual.

var radio: float = 40.0
var duracion: float = 0.7
var color: Color = Color(1.0, 0.4, 0.4)
var _t: float = 0.0


func _process(delta: float) -> void:
	_t += delta
	if _t >= duracion:
		queue_free()
	queue_redraw()


func _draw() -> void:
	var p: float = clampf(_t / duracion, 0.0, 1.0)
	var parpadeo: float = 0.5 + 0.5 * sin(_t * 30.0)
	draw_arc(Vector2.ZERO, radio, 0.0, TAU, 32, Color(color, 0.4 + 0.5 * parpadeo), 4.0)
	draw_circle(Vector2.ZERO, radio * p, Color(color, 0.25))
