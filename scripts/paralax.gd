extends Sprite2D

# Variables pour ajuster l'intensité de l'effet de parallaxe et le mouvement aléatoire
@export var parallax_strength : float = 0.05
@export var max_horizontal_offset : float = 10.0
@export var max_vertical_offset : float = 10.0
@export var random_movement_speed : float = 0.5
@export var acceleration : float = 2  # Vitesse à laquelle le parallaxe accélère/décélère
@export var max_parallax_offset_left : float = -80.0  # Limite max vers la gauche
@export var max_parallax_offset_right : float = 80.0  # Limite max vers la droite
@export var max_parallax_offset_up : float = -40.0  # Limite max vers le haut
@export var max_parallax_offset_down : float = 40.0  # Limite max vers le bas
@export var deceleration_distance : float = 10.0  # Distance où la décélération commence

var initial_position : Vector2
var random_offset : Vector2 = Vector2.ZERO
var time_elapsed : float = 0.0
var current_parallax_offset : Vector2 = Vector2.ZERO

func _ready():
	# Stocker la position initiale du fond
	initial_position = position

func _process(delta: float) -> void:
	# Obtenir la position de la souris dans le viewport
	var mouse_pos = get_viewport().get_mouse_position()
	var viewport_size = get_viewport_rect().size

	# Calculer le déplacement cible du parallaxe en fonction de la position de la souris
	var target_parallax_offset = Vector2(
		(viewport_size.x / 2 - mouse_pos.x) * parallax_strength,
		(viewport_size.y / 2 - mouse_pos.y) * parallax_strength
	)
	
	# Appliquer une décélération si on approche des limites horizontales
	if current_parallax_offset.x < max_parallax_offset_left + deceleration_distance:
		var left_dist_factor = (current_parallax_offset.x - max_parallax_offset_left) / deceleration_distance
		target_parallax_offset.x *= clamp(left_dist_factor, 0.0, 1.0)
	elif current_parallax_offset.x > max_parallax_offset_right - deceleration_distance:
		var right_dist_factor = (max_parallax_offset_right - current_parallax_offset.x) / deceleration_distance
		target_parallax_offset.x *= clamp(right_dist_factor, 0.0, 1.0)
	
	# Appliquer une décélération si on approche des limites verticales
	if current_parallax_offset.y < max_parallax_offset_up + deceleration_distance:
		var up_dist_factor = (current_parallax_offset.y - max_parallax_offset_up) / deceleration_distance
		target_parallax_offset.y *= clamp(up_dist_factor, 0.0, 1.0)
	elif current_parallax_offset.y > max_parallax_offset_down - deceleration_distance:
		var down_dist_factor = (max_parallax_offset_down - current_parallax_offset.y) / deceleration_distance
		target_parallax_offset.y *= clamp(down_dist_factor, 0.0, 1.0)
	
	# Accélérer/décélérer progressivement vers la position cible
	current_parallax_offset = lerp(current_parallax_offset, target_parallax_offset, acceleration * delta)
	
	# Limiter le déplacement du parallaxe entre les valeurs maximales
	current_parallax_offset.x = clamp(current_parallax_offset.x, max_parallax_offset_left, max_parallax_offset_right)
	current_parallax_offset.y = clamp(current_parallax_offset.y, max_parallax_offset_up, max_parallax_offset_down)
	
	# Mise à jour du mouvement aléatoire
	time_elapsed += delta * random_movement_speed
	random_offset.x = sin(time_elapsed) * max_horizontal_offset
	random_offset.y = cos(time_elapsed * 1.3) * max_vertical_offset

	# Appliquer le mouvement combiné (parallaxe + mouvement aléatoire)
	position = initial_position + current_parallax_offset + random_offset
