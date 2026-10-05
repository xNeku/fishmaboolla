class_name BolaDatos
extends Resource
## Un tamaño (tier) de bola. Se encadenan con `siguiente`: al romperse, la bola
## se divide en dos de ese tier. Si `siguiente` está vacío, la bola desaparece.

@export var id: StringName = &"bola"
## Radio en px.
@export var radio: float = 40.0
## Altura que alcanza al rebotar en el suelo, medida desde el suelo hasta la parte
## baja de la bola. Fija por tier, para que los arcos sean memorizables.
@export var altura_rebote: float = 350.0
## Velocidad horizontal en px/s (constante, solo cambia de sentido en las paredes).
@export var velocidad_horizontal: float = 150.0
## Impulso hacia arriba con el que sale esta bola cuando nace de una división.
@export var impulso_division: float = 350.0
@export var color: Color = Color(0.9, 0.3, 0.35)
## Tier al que se divide. Vacío = es el más pequeño.
@export var siguiente: BolaDatos
