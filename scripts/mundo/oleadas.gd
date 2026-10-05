class_name Oleadas
extends Node
## Dirige las tandas de bolas del Acto: lanza los patrones, espera a que se rompan
## todas las bolas y hace una pausa (descanso, aún sin pesca) hasta la siguiente tanda.

signal tanda_iniciada(indice: int)
signal descanso_iniciado(segundos: float)
signal tandas_terminadas

enum Estado { LANZANDO, DESCANSO, TERMINADO }

@export var sala: Sala
@export var tandas: Array[TandaBolas] = []
## Espera antes de la primera tanda.
@export var segundos_inicio: float = 1.0
## Duración del descanso entre tandas (más adelante será para pescar).
@export var segundos_descanso: float = 5.0
## Tiempo que se ve el aviso antes de que salga la bola.
@export var segundos_aviso: float = 0.7

var estado: Estado = Estado.LANZANDO
var indice_tanda: int = -1
## Bolas de la tanda actual que aún no han salido.
var pendientes: int:
	get:
		return _cola.size()

var _t: float = 0.0
var _espera: float = 0.0
var _cola: Array[Dictionary] = []


func _ready() -> void:
	_espera = segundos_inicio
	_preparar_tanda(0)


func _physics_process(delta: float) -> void:
	match estado:
		Estado.LANZANDO:
			_t += delta
			_procesar_cola()
			if _cola.is_empty() and get_tree().get_nodes_in_group("bolas").is_empty():
				if indice_tanda + 1 < tandas.size():
					estado = Estado.DESCANSO
					_espera = segundos_descanso
					descanso_iniciado.emit(segundos_descanso)
				else:
					estado = Estado.TERMINADO
					tandas_terminadas.emit()
		Estado.DESCANSO:
			_espera -= delta
			if _espera <= 0.0:
				_preparar_tanda(indice_tanda + 1)


## Segundos que quedan de descanso (0 si no está en descanso).
func descanso_restante() -> float:
	return maxf(0.0, _espera) if estado == Estado.DESCANSO else 0.0


func _preparar_tanda(i: int) -> void:
	indice_tanda = i
	estado = Estado.LANZANDO
	_t = -segundos_inicio if i == 0 else 0.0
	_cola.clear()
	var tanda: TandaBolas = tandas[i]
	var cursor: float = 0.0
	for patron: PatronBolas in tanda.patrones:
		for e: EntradaPatron in patron.entradas:
			_cola.append({"t": cursor + e.retraso, "entrada": e, "aviso": false})
		cursor += patron.duracion() + tanda.segundos_entre_patrones
	tanda_iniciada.emit(i)


func _procesar_cola() -> void:
	for item: Dictionary in _cola.duplicate():
		var e: EntradaPatron = item["entrada"]
		var t: float = item["t"]
		if not item["aviso"] and _t >= t:
			item["aviso"] = true
			_crear_aviso(e)
		if _t >= t + segundos_aviso:
			_crear_bola(e)
			_cola.erase(item)


## Posición de salida (centro de la bola) y sentido horizontal según el origen.
func calcular_salida(e: EntradaPatron) -> Dictionary:
	var l: Rect2 = sala.limites
	var r: float = e.bola.radio
	var x: float = l.position.x + r
	var y: float = l.position.y + r
	var dir: int = 1
	match e.origen:
		EntradaPatron.Origen.TECHO:
			x = l.position.x + r + e.x_relativo * (l.size.x - 2.0 * r)
			dir = -1 if e.direccion < 0 else 1
		EntradaPatron.Origen.ESQUINA_SUP_DER:
			x = l.end.x - r
			dir = -1
		EntradaPatron.Origen.ESQUINA_INF_IZQ:
			y = l.end.y - r
		EntradaPatron.Origen.ESQUINA_INF_DER:
			x = l.end.x - r
			y = l.end.y - r
			dir = -1
	return {"posicion": Vector2(x, y), "direccion": dir}


func _crear_aviso(e: EntradaPatron) -> void:
	var salida: Dictionary = calcular_salida(e)
	var aviso := AvisoSpawn.new()
	aviso.position = salida["posicion"]
	aviso.radio = e.bola.radio
	aviso.duracion = segundos_aviso
	aviso.color = e.bola.color
	get_parent().add_child(aviso)


func _crear_bola(e: EntradaPatron) -> void:
	var salida: Dictionary = calcular_salida(e)
	var bola: Bola = (load(Bola.RUTA_ESCENA) as PackedScene).instantiate() as Bola
	bola.datos = e.bola
	bola.direccion_inicial = salida["direccion"]
	bola.impulso_inicial = e.impulso
	bola.limites = sala.limites
	bola.gravedad = sala.gravedad_bolas
	bola.position = salida["posicion"]
	get_parent().add_child(bola)
