class_name JugadorConfig
extends Resource
## Valores de feel del marinero. Editable en el inspector (data/jugador/jugador_base.tres).

@export_group("Movimiento")
## Velocidad horizontal en px/s. Instantánea, sin aceleración.
@export var velocidad_lateral: float = 630.0
## Gravedad en px/s². Más alta = salto más seco.
@export var gravedad: float = 2200.0
## Velocidad inicial del salto en px/s. Altura ≈ v² / (2·g).
@export var velocidad_salto: float = 900.0

@export_group("Dash")
## Velocidad horizontal durante el dash en px/s.
@export var dash_velocidad: float = 1650.0
## Duración del dash en segundos. Distancia = velocidad × duración.
@export var dash_duracion: float = 0.15
## Espera tras acabar un dash antes de poder hacer otro, en segundos.
@export var dash_cooldown: float = 0.4
## Si el dash da i-frames (invulnerable mientras dura).
@export var dash_invulnerable: bool = true
## Tiempo máximo entre dos taps de la misma dirección para activar el dash.
@export var ventana_doble_tap: float = 0.25

@export_group("Arma")
## Espera entre disparos en segundos. Manteniendo el botón dispara a este ritmo.
@export var cooldown_disparo: float = 0.25

@export_group("Cuerpo")
@export var ancho: float = 48.0
@export var alto: float = 80.0
