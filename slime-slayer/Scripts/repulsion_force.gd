extends CharacterBody2D

var speed: float = 200.0  # Base speed for the repulsion
var max_force: float = 600.0  # Maximum repulsion force (speed * 3)
var repulsion_duration: float = 1.2  # Duration in seconds
var repulsion_timer: float = 0.0  # Tracks elapsed time
var is_repulsing: bool = false  # Tracks if repulsion is active
var repulsion_velocity: Vector2 = Vector2.ZERO  # Stores the repulsion velocity

func _ready() -> void:
	# Connect the Area2D's body_exited signal (adjust "Area2D" to your node's name)
	$Area2D.body_exited.connect(_on_area_2d_body_exited)

func _physics_process(delta: float) -> void:
	if is_repulsing:
		# Increment timer
		repulsion_timer += delta
		
		# Calculate logarithmic decay (t ranges from 0 to 1.2 seconds)
		var t: float = repulsion_timer / repulsion_duration
		if t <= 1.0:
			# Logarithmic decay: force = max_force * (1 - log(t + 1) / log(2.2))
			var decay: float = 1.0 - log(t + 1.0) / log(2.2)  # Adjust log base for curve
			var current_force: float = max_force * decay
			velocity = repulsion_velocity * current_force / max_force
		else:
			# Stop repulsion after 1.2 seconds
			is_repulsing = false
			velocity = Vector2.ZERO  # Reset velocity or adjust as needed
		
		# Apply physics movement
		move_and_slide()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":  # Check if the exiting body is the player
		repulsion_force()

func repulsion_force() -> void:
	# Calculate repulsion direction (away from player)
	var target_direction: Vector2 = (Globals.PLAYER.position - position).normalized()
	var repulsion_dir: Vector2 = -target_direction
	
	# Set initial repulsion velocity
	repulsion_velocity = repulsion_dir * speed * 3
	max_force = speed * 3  # Store max force for logarithmic decay
	
	# Start repulsion effect
	repulsion_timer = 0.0
	is_repulsing = true
