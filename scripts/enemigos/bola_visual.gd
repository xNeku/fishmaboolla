class_name BolaVisual
extends Node2D
## Programmer art de la bola. Solo dibuja; lee los datos de la Bola.

@export var bola: Bola


func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	var r: float = bola.datos.radio
	var c: Color = bola.datos.color
	draw_circle(Vector2.ZERO, r, c)
	draw_arc(Vector2.ZERO, r, 0.0, TAU, 32, c.darkened(0.45), 3.0)
	draw_circle(Vector2(-r * 0.3, -r * 0.3), r * 0.18, Color(1.0, 1.0, 1.0, 0.35))
