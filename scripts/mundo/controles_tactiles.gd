class_name ControlesTactiles
extends Control
## Botones táctiles de PRUEBA (programmer art) ligados a acciones del Input Map.
## Multitáctil: cada dedo manda su acción. No es diseño final de controles.

## Solo activo si hay pantalla táctil (se puede forzar desde fuera).
var activo: bool = DisplayServer.is_touchscreen_available()

var _zonas: Dictionary = {
	&"mover_izq": Rect2(30.0, 520.0, 170.0, 170.0),
	&"mover_der": Rect2(220.0, 520.0, 170.0, 170.0),
	&"saltar": Rect2(1080.0, 520.0, 170.0, 170.0),
}
var _dedos: Dictionary = {}  # índice de dedo -> acción
var _etiquetas: Dictionary = {
	&"mover_izq": "<",
	&"mover_der": ">",
	&"saltar": "^",
}


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func _input(event: InputEvent) -> void:
	if not activo:
		return
	if event is InputEventScreenTouch:
		var toque: InputEventScreenTouch = event
		if toque.pressed:
			_asignar(toque.index, _accion_en(toque.position))
		else:
			_asignar(toque.index, &"")
	elif event is InputEventScreenDrag:
		var arrastre: InputEventScreenDrag = event
		_asignar(arrastre.index, _accion_en(arrastre.position))


func _accion_en(pos: Vector2) -> StringName:
	for accion: StringName in _zonas:
		if (_zonas[accion] as Rect2).has_point(pos):
			return accion
	return &""


func _asignar(dedo: int, accion: StringName) -> void:
	var actual: StringName = _dedos.get(dedo, &"")
	if actual == accion:
		return
	if actual != &"":
		_dedos.erase(dedo)
		if not _accion_en_uso(actual):
			Input.action_release(actual)
	if accion != &"":
		_dedos[dedo] = accion
		Input.action_press(accion)
	queue_redraw()


func _accion_en_uso(accion: StringName) -> bool:
	return _dedos.values().has(accion)


func _draw() -> void:
	if not activo:
		return
	for accion: StringName in _zonas:
		var r: Rect2 = _zonas[accion]
		var pulsado: bool = _accion_en_uso(accion)
		draw_rect(r, Color(1.0, 1.0, 1.0, 0.25 if pulsado else 0.08))
		draw_rect(r, Color(1.0, 1.0, 1.0, 0.5), false, 3.0)
		draw_string(ThemeDB.fallback_font, r.position + Vector2(0.0, r.size.y * 0.62), _etiquetas[accion],
				HORIZONTAL_ALIGNMENT_CENTER, r.size.x, 64, Color(1.0, 1.0, 1.0, 0.7))
