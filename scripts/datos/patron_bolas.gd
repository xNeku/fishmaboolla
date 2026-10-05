class_name PatronBolas
extends Resource
## Un grupo de bolas que salen juntas o escalonadas (una cascada, una pinza...).

@export var nombre: String = "patron"
@export var entradas: Array[EntradaPatron] = []


## Retraso de la última bola: cuándo termina de salir el patrón.
func duracion() -> float:
	var d: float = 0.0
	for e: EntradaPatron in entradas:
		d = maxf(d, e.retraso)
	return d
