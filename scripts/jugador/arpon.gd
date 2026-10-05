class_name Arpon
extends Node2D
## Proyectil recto hacia arriba. La posición es la PUNTA; el cuerpo se extiende hacia abajo.
## Se detiene en el primer impacto con una bola. Desaparece al llegar al techo.
## Colisiona por barrido (cubre todo el tramo recorrido), así no atraviesa bolas aunque vaya rápido.

## Velocidad en px/s.
@export var velocidad: float = 2200.0
## Largo del cuerpo en px. Debe ser mayor que lo que avanza en un frame.
@export var largo: float = 80.0
@export var ancho: float = 10.0

var limites: Rect2 = Rect2()


func _ready() -> void:
	add_to_group("arpones")


func _physics_process(delta: float) -> void:
	var y_previa: float = position.y
	position.y -= velocidad * delta
	var arriba: float = maxf(position.y, limites.position.y)
	var abajo: float = y_previa + largo
	var zona := Rect2(position.x - ancho * 0.5, arriba, ancho, maxf(abajo - arriba, 0.0))
	for nodo: Node in get_tree().get_nodes_in_group("bolas"):
		var bola: Bola = nodo as Bola
		if _circulo_toca_rect(bola.position, bola.radio, zona):
			bola.recibir_impacto()
			queue_free()
			return
	if position.y <= limites.position.y:
		queue_free()


func _circulo_toca_rect(centro: Vector2, radio: float, rect: Rect2) -> bool:
	var cercano := Vector2(
			clampf(centro.x, rect.position.x, rect.end.x),
			clampf(centro.y, rect.position.y, rect.end.y))
	return cercano.distance_squared_to(centro) <= radio * radio
