extends CharacterBody2D

# Variables
@export var speed: int = 35 ## Speed!!
@export var life: int = 3 ## Life, duh
@export var attack: int = 10 ## Attack damage
@export var vision_range: int = 300  ## Diameter of the vision box

## Its element. It will determine abilities and attributes
## Accepted values: base, air, water, earth, fire
@export var element: String = "base"
@export var size: String = "small" ## Acceptable sizes: small, medium, large

var random_direction: Vector2 = Vector2.ZERO # Applies random variance in direction
var randomness_factor: float = 0.2  # Strength of randomness
var is_pursuing: bool = false # If pursuing runs pursuing code

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
		var random_offset = Vector2( #randomness offset vector
			randf_range(-randomness_factor, randomness_factor),
			randf_range(-randomness_factor, randomness_factor)
		).normalized() * 0.5 # 0.5 scales down randomness factor so it does not overtake main path to follow the PLAYER
		var move_direction = (target_direction + random_offset).normalized() #Final vector from SLIME to PLAYER with randomness
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

func _draw() -> void:
	# Draws a vision box for debugging
	draw_rect(Rect2(-vision_range/2, -vision_range/2, vision_range, vision_range), Color(1, 0.5, 0, 0.7), false)
