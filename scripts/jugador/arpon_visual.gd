class_name ArponVisual
extends Node2D
## Programmer art del arpón: cuerpo claro con punta triangular. Solo dibuja.

@export var arpon: Arpon


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	var w: float = arpon.ancho
	var largo: float = arpon.largo
	var cuerpo: Color = Color(0.95, 0.95, 0.85)
	draw_rect(Rect2(-w * 0.5, 0.0, w, largo), cuerpo)
	draw_colored_polygon(PackedVector2Array([Vector2(0.0, -18.0), Vector2(-w * 1.1, 4.0), Vector2(w * 1.1, 4.0)]), Color(1.0, 1.0, 1.0))
	draw_rect(Rect2(-w * 0.5, 0.0, w, largo), Color(0.5, 0.5, 0.45), false, 2.0)
