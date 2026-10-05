class_name JugadorInput
extends Node
## Traduce las acciones del Input Map en órdenes al Jugador.
## El doble tap (A-A / D-D) se detecta aquí; la lógica solo recibe "dash".

@export var jugador: Jugador

var _t: float = 0.0
var _ultimo_tap: Dictionary = {}


func _init() -> void:
	# Corre antes que el Jugador para que las órdenes se apliquen en el mismo frame.
	process_physics_priority = -10


func _physics_process(delta: float) -> void:
	_t += delta
	jugador.orden_mover(Input.get_axis("mover_izq", "mover_der"))
	if Input.is_action_just_pressed("saltar"):
		jugador.orden_saltar()
	if Input.is_action_pressed("disparar"):
		jugador.orden_disparar()
	_comprobar_doble_tap("mover_izq", -1)
	_comprobar_doble_tap("mover_der", 1)


func _comprobar_doble_tap(accion: StringName, direccion: int) -> void:
	if not Input.is_action_just_pressed(accion):
		return
	var previo: float = _ultimo_tap.get(accion, -INF)
	if _t - previo <= jugador.config.ventana_doble_tap:
		jugador.orden_dash(direccion)
		_ultimo_tap.erase(accion)
	else:
		_ultimo_tap[accion] = _t
