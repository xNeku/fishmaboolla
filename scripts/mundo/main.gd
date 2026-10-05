extends Node2D
## Nivel de prueba. El decorado, la sala, el jugador y las oleadas viven en la
## escena (main.tscn); este script conecta las piezas y pinta el estado de depuración.

## Tras morir, espera antes de aceptar el reinicio (evita reiniciar sin querer con el autodisparo).
const SEGUNDOS_ANTES_REINICIO: float = 1.0
const ESCENA_ARPON: PackedScene = preload("res://scenes/arpon.tscn")

@onready var _sala: Sala = $Sala
@onready var _jugador: Jugador = $Jugador
@onready var _oleadas: Oleadas = $Oleadas
@onready var _estado: Label = $Estado
@onready var _fin_partida: Label = $FinPartida

var _tocando: bool = false
var _tiempo_muerto: float = 0.0


func _ready() -> void:
	_jugador.limites = _sala.limites
	_jugador.murio.connect(_al_morir)
	_jugador.disparado.connect(_crear_arpon)


func _physics_process(delta: float) -> void:
	if _jugador.muerto:
		_tiempo_muerto += delta
		if _tiempo_muerto >= SEGUNDOS_ANTES_REINICIO and Input.is_action_just_pressed("disparar"):
			get_tree().reload_current_scene()
		return
	_comprobar_contacto()


func _al_morir() -> void:
	_fin_partida.visible = true
	_oleadas.set_physics_process(false)


func _process(_delta: float) -> void:
	var estado: String = "dash" if _jugador.dashing else ("suelo" if _jugador.en_suelo else "aire")
	var n_bolas: int = get_tree().get_nodes_in_group("bolas").size()
	var n_arpones: int = get_tree().get_nodes_in_group("arpones").size()
	_estado.text = "%s  cd dash: %.2f\nbolas: %d  arpones: %d  vidas: %d/%d\n%s" % [estado, _jugador.cooldown_dash_restante, n_bolas, n_arpones, _jugador.vidas, _jugador.config.vidas_maximas, _texto_oleadas()]


## Avisa al jugador una vez por contacto (no cada frame mientras dura el solape).
func _comprobar_contacto() -> void:
	var solapa: bool = false
	for nodo: Node in get_tree().get_nodes_in_group("bolas"):
		var bola: Bola = nodo as Bola
		if _jugador.toca_circulo(bola.position, bola.radio):
			solapa = true
			break
	if not solapa:
		_tocando = false
	elif not _tocando and _jugador.recibir_toque():
		# Si el toque cayó en i-frames, no cuenta y se reintenta mientras siga el solape.
		_tocando = true


func _crear_arpon(origen: Vector2) -> void:
	var arpon: Arpon = ESCENA_ARPON.instantiate() as Arpon
	arpon.limites = _sala.limites
	arpon.position = origen
	add_child(arpon)


func _texto_oleadas() -> String:
	var n: int = _oleadas.tandas.size()
	match _oleadas.estado:
		Oleadas.Estado.DESCANSO:
			return "descanso: %.1f s  (siguiente tanda %d/%d)" % [_oleadas.descanso_restante(), _oleadas.indice_tanda + 2, n]
		Oleadas.Estado.TERMINADO:
			return "tandas terminadas (%d/%d)" % [n, n]
		_:
			return "tanda %d/%d  por salir: %d" % [_oleadas.indice_tanda + 1, n, _oleadas.pendientes]
