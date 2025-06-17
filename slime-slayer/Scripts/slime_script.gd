extends CharacterBody2D

# Variables
@export var speed: int = 35
@export var life: int = 3
@export var attack: int = 10
@export var vision_range: int = 300  ## Diameter of the vision box
## Accepted: fire, water, earth, air
@export var element: String = "base"
##Accepted: small, medium, large
@export var size: String = "small"

var random_direction: Vector2 = Vector2.ZERO # Applies random variance in direction

# If pursuing runs pursuing code
var is_pursuing: bool = false

func _ready() -> void:
	set_random_direction()
	add_to_group("enemies")

func take_damage(amount):
	life -= amount
	return life

func give_damage():
	Globals.HERO_HEALTH -= attack #check attack # in variables

func _physics_process(_delta: float) -> void:
	
	# Check if player is in vision box
	update_pursuit()
	
	# If SLIME is pursuing runs SLIME movement code
	if is_pursuing:
		# Move toward PLAYER with some randomness
		var target_direction = (Globals.PLAYER.position - position).normalized() #vector from SLIME to PLAYER 
		if randf() < 0.01:  # Change direction occasionally (1% chance per frame)
			set_random_direction()
		var move_direction = (target_direction + 1.75*random_direction).normalized() #Final vector from SLIME to PLAYER with randomness
		velocity = move_direction * speed
	
	else:
		# Wander randomly
		velocity = random_direction * speed
		if randf() < 0.01:  # Change direction occasionally (1% chance per frame)
			set_random_direction()

	move_and_slide() # Built in function for characterbody2D that deals with movement

#Grabs a random vector direction
func set_random_direction() -> void:
	random_direction = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()

#Checks if PLAYER is within vision and if it needs to pursue
func update_pursuit() -> void:
	
	# checks if PLAYER is still in the game
	if not is_instance_valid(Globals.PLAYER):
		is_pursuing = false
		return
	
	#Grabs distance from SLIME to PLAYER
	var distance_to_player = position.distance_to(Globals.PLAYER.position)
	
	# Check if player is within the vision box 
	var dx = abs(Globals.PLAYER.position.x - position.x)
	var dy = abs(Globals.PLAYER.position.y - position.y)
	if dx < vision_range and dy < vision_range:
		is_pursuing = true
	else:
		is_pursuing = false

func repulsion_force() -> void:
	pass

func _draw() -> void:
	# Draws a vision box for debugging
	draw_rect(Rect2(-vision_range/2, -vision_range/2, vision_range, vision_range), Color(1, 0.5, 0, 0.7), false)
