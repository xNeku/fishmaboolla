extends Node2D
## Sala de prueba. El decorado y el jugador viven en la escena (main.tscn);
## este script solo pinta el estado de depuración.

@onready var _jugador: Jugador = $Jugador
@onready var _estado: Label = $Estado


func _process(_delta: float) -> void:
	var estado: String = "dash" if _jugador.dashing else ("suelo" if _jugador.en_suelo else "aire")
	_estado.text = "%s  cd dash: %.2f" % [estado, _jugador.cooldown_dash_restante]
