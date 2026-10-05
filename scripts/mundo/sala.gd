class_name Sala
extends Node2D
## Cubículo de juego: suelo, paredes y techo. Los límites reales los define el nodo
## `Limites` (redimensiónalo en el editor); las paredes son solo decorado.

## Gravedad de las bolas en px/s². Constante por sala (así un Acto puede cambiarla).
@export var gravedad_bolas: float = 1500.0

@onready var _limites: ReferenceRect = $Limites

## Rectángulo interior jugable, en coordenadas globales. El borde inferior es el suelo.
var limites: Rect2:
	get:
		return _limites.get_global_rect()
