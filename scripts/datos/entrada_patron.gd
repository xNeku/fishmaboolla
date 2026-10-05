class_name EntradaPatron
extends Resource
## Una bola dentro de un patrón: qué tipo, desde dónde sale y cuándo.

enum Origen { TECHO, ESQUINA_SUP_IZQ, ESQUINA_SUP_DER, ESQUINA_INF_IZQ, ESQUINA_INF_DER }

@export var bola: BolaDatos
@export var origen: Origen = Origen.TECHO
## Solo para TECHO: posición horizontal, 0 = pared izquierda, 1 = pared derecha.
@export_range(0.0, 1.0, 0.01) var x_relativo: float = 0.5
## Solo para TECHO: sentido horizontal. Las esquinas salen siempre hacia dentro.
@export_enum("Izquierda:-1", "Derecha:1") var direccion: int = 1
## Segundos desde el inicio del patrón hasta que sale esta bola (el aviso empieza ahí).
@export var retraso: float = 0.0
## Impulso inicial hacia arriba en px/s (0 = sale en caída libre).
@export var impulso: float = 0.0
