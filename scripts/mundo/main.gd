extends Node2D
## Nivel de prueba. El decorado, la sala y el jugador viven en la escena (main.tscn);
## este script conecta las piezas y pinta el estado de depuración.

@onready var _sala: Sala = $Sala
@onready var _jugador: Jugador = $Jugador
@onready var _estado: Label = $Estado


func _ready() -> void:
	_jugador.limites = _sala.limites


func _process(_delta: float) -> void:
	var estado: String = "dash" if _jugador.dashing else ("suelo" if _jugador.en_suelo else "aire")
	_estado.text = "%s  cd dash: %.2f" % [estado, _jugador.cooldown_dash_restante]
