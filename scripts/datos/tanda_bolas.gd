class_name TandaBolas
extends Resource
## Una tanda del Acto: patrones lanzados en orden. Se acaba cuando han salido todos
## y el jugador ha roto todas las bolas.

@export var nombre: String = "tanda"
@export var patrones: Array[PatronBolas] = []
## Pausa entre que termina de salir un patrón y empieza el siguiente.
@export var segundos_entre_patrones: float = 2.0
