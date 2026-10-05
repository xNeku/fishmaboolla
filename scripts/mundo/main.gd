extends Node2D
## Escena base de arranque. Placeholder: se sustituirá por la sala de juego.

const SUELO_Y: float = 640.0


func _draw() -> void:
	var tam: Vector2 = get_viewport_rect().size
	draw_rect(Rect2(0.0, SUELO_Y, tam.x, tam.y - SUELO_Y), Color(0.2, 0.28, 0.35))
	draw_string(ThemeDB.fallback_font, Vector2(24.0, 40.0), "Fishmaboolla — base", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 24)


func _ready() -> void:
	print("Fishmaboolla: base arrancada")
