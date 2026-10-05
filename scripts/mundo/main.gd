extends Node2D
## Nivel de prueba. El decorado, la sala, el jugador y la bola inicial viven en la
## escena (main.tscn); este script conecta las piezas y pinta el estado de depuración.

const SEGUNDOS_REAPARICION: float = 1.2

@onready var _sala: Sala = $Sala
@onready var _jugador: Jugador = $Jugador
@onready var _bola_inicial: Bola = $Bola
@onready var _estado: Label = $Estado

var _datos_inicial: BolaDatos
var _pos_inicial: Vector2
var _dir_inicial: int
var _espera: float = 0.0
var _tocando: bool = false
var _toques: int = 0


func _ready() -> void:
	_jugador.limites = _sala.limites
	# Se recuerda cómo es la bola colocada en la escena para reponerla (depuración).
	_datos_inicial = _bola_inicial.datos
	_pos_inicial = _bola_inicial.position
	_dir_inicial = _bola_inicial.direccion_inicial
	_preparar(_bola_inicial)
	_jugador.tocado.connect(func() -> void: _toques += 1)


func _physics_process(delta: float) -> void:
	_comprobar_contacto()
	if get_tree().get_nodes_in_group("bolas").is_empty():
		_espera += delta
		if _espera >= SEGUNDOS_REAPARICION:
			_espera = 0.0
			_reponer_bola()
	else:
		_espera = 0.0


func _process(_delta: float) -> void:
	var estado: String = "dash" if _jugador.dashing else ("suelo" if _jugador.en_suelo else "aire")
	var n_bolas: int = get_tree().get_nodes_in_group("bolas").size()
	_estado.text = "%s  cd dash: %.2f\nbolas: %d  toques: %d" % [estado, _jugador.cooldown_dash_restante, n_bolas, _toques]


# DEPURACIÓN: clic/toque sobre una bola la rompe. Se quita cuando haya arpón.
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var punto: Vector2 = (make_input_local(event) as InputEventMouseButton).position
		for nodo: Node in get_tree().get_nodes_in_group("bolas"):
			var bola: Bola = nodo as Bola
			if bola.position.distance_to(punto) <= bola.radio:
				bola.recibir_impacto()
				break


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


func _preparar(bola: Bola) -> void:
	bola.limites = _sala.limites
	bola.gravedad = _sala.gravedad_bolas


func _reponer_bola() -> void:
	var bola: Bola = (load(Bola.RUTA_ESCENA) as PackedScene).instantiate() as Bola
	bola.datos = _datos_inicial
	bola.direccion_inicial = _dir_inicial
	bola.position = _pos_inicial
	_preparar(bola)
	add_child(bola)
