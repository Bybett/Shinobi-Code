extends CharacterBody2D
var life = 3
var attack = 10

@export var SPEED: float = 50.0
@export var VISION_RANGE: float = 350.0  # Width/height of the vision box
@export var DETECTION_RANGE: float = 300.0  # Distance to start pursuing
@export var RANDOMNESS_FACTOR: float = 0.2  # How much randomness in movement

var is_pursuing: bool = false
var random_direction: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Ensure the Area2D can detect overlaps
	#self.monitorable = true  # Can be detected by other Area2D nodes
	#self.monitoring = true   # Can detect other Area2D nodes entering it
	set_random_direction()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass  # Add movement or logic here if needed

func take_damage(amount):
	life -= amount
	return life
	
func give_damage():
	Globals.HERO_HEALTH -= attack
	pass

# Called when another Area2D enters this one's hitbox
#func _on_area_entered(area: Area2D) -> void:
	#if area.name == "SwordSwipe":  # Che ck if it's the player
		#print(life, "points") 
		#life -= 1
	#if life == 0:
		#queue_free()
		

func _physics_process(_delta: float) -> void:
	# Check if player is in vision box
	update_pursuit()
	
	if is_pursuing:
		# Move toward player with some randomness
		var target_direction = (Globals.PLAYER.position - position).normalized()
		var random_offset = Vector2(
			randf_range(-RANDOMNESS_FACTOR, RANDOMNESS_FACTOR),
			randf_range(-RANDOMNESS_FACTOR, RANDOMNESS_FACTOR)
		).normalized() * 0.5
		var move_direction = (target_direction + random_offset).normalized()
		velocity = move_direction * SPEED
	else:
		# Wander randomly
		velocity = random_direction * SPEED
		if randf() < 0.01:  # Change direction occasionally (1% chance per frame)
			set_random_direction()

	move_and_slide()

func set_random_direction() -> void:
	random_direction = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()

func update_pursuit() -> void:
	if not is_instance_valid(Globals.PLAYER):
		is_pursuing = false
		return
	
	var distance_to_player = position.distance_to(Globals.PLAYER.position)
	# Check if player is within the vision box (simplified as a square for now)
	var dx = abs(Globals.PLAYER.position.x - position.x)
	var dy = abs(Globals.PLAYER.position.y - position.y)
	if dx < VISION_RANGE and dy < VISION_RANGE and distance_to_player <= DETECTION_RANGE:
		is_pursuing = true
	else:
		is_pursuing = false

func _draw() -> void:
	# Optional: Draw vision box for debugging
	draw_rect(Rect2(-VISION_RANGE/2, -VISION_RANGE/2, VISION_RANGE, VISION_RANGE), Color(1, 0, 0, 0.2), false)
