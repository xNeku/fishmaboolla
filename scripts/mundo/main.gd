extends Node2D
## Sala de prueba. Monta el jugador por código. Placeholder hasta tener sala real.

const SUELO_Y: float = 640.0
const ANCHO_SALA: float = 1280.0

var _jugador: Jugador


func _ready() -> void:
	var config: JugadorConfig = load("res://data/jugador/jugador_base.tres")

	_jugador = Jugador.new()
	_jugador.name = "Jugador"
	_jugador.config = config
	_jugador.limites = Rect2(0.0, 0.0, ANCHO_SALA, SUELO_Y)
	_jugador.position = Vector2(ANCHO_SALA * 0.5, SUELO_Y)
	add_child(_jugador)

	var visual := JugadorVisual.new()
	visual.name = "Visual"
	visual.jugador = _jugador
	_jugador.add_child(visual)

	var input := JugadorInput.new()
	input.name = "Input"
	input.jugador = _jugador
	_jugador.add_child(input)


func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	var tam: Vector2 = get_viewport_rect().size
	draw_rect(Rect2(0.0, SUELO_Y, tam.x, tam.y - SUELO_Y), Color(0.2, 0.28, 0.35))
	if _jugador == null:
		return
	var estado: String = "dash" if _jugador.dashing else ("suelo" if _jugador.en_suelo else "aire")
	var texto: String = "%s  cd dash: %.2f" % [estado, _jugador.cooldown_dash_restante]
	draw_string(ThemeDB.fallback_font, Vector2(24.0, 40.0), texto, HORIZONTAL_ALIGNMENT_LEFT, -1.0, 24)
