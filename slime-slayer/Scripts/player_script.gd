extends CharacterBody2D

# Constants
@export var speed: int = 250
@export var attack_distance: int = 125

# Variables
var direction: Vector2 # Player's director of movement

#Bools
@export var is_moving: bool = true
var is_invulnerable: bool = false
var in_body: bool = false #is slime touching player?

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.PLAYER = self # Makes PLAYER node from Globals accessible in this script
	global_position = Vector2(102, 100) # Set Player's position
	$HitBox.body_entered.connect(_on_area_2d_body_entered) # Associates Hit Box with _on_area_2d... pre-built function

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Movement function WASD of PLAYER controls
	if is_moving:
		if (Input.is_action_pressed("Up")):
			position.y -= speed * delta # distance = speed * time
			direction = Vector2.UP
		if (Input.is_action_pressed("Down")):
			position.y += speed * delta
			direction = Vector2.DOWN
		if (Input.is_action_pressed("Left")):
			position.x -= speed * delta
			direction = Vector2.LEFT
		if (Input.is_action_pressed("Right")):
			position.x += speed * delta
			direction = Vector2.RIGHT
			
		#Sword Swipe Function Initialized with Controls 
		if (Input.is_action_just_released("Space")):
			if Globals.SWORD_SWIPE_SCENE:
				var sword_swipe = Globals.SWORD_SWIPE_SCENE.instantiate()
				sword_swipe.position = direction * attack_distance
				
				#Positions sword swipe based on what WASD is pressed
				if (direction == Vector2.UP): 
					sword_swipe.rotation_degrees = -90
				elif (direction == Vector2.DOWN):
					sword_swipe.rotation_degrees = 90
				
				add_child(sword_swipe) #Sword enters the scene
			else:
				print("sword_swipe_scene run failed")
			
# If an ENEMY enters PLAYER's hitbox, runs take_damage()
func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		take_damage(1)
		in_body = true
		print("HITBOX entered")

# enemy leaves player body
func _on_area_2d_body_exited(body: Node) -> void:
	if body.is_in_group("enemies"):
		in_body = false

			
# Deals damage to PLAYER
func take_damage(amount: int) -> void:
	
	#If the PLAYER cannot be hurt don't take damage and exit function
	if is_invulnerable:
		return
	
	Globals.PLAYER_HEALTH -= amount #Subtracks PLAYER health
	
	# If PLAYER has no more health, GAME OVER
	if Globals.PLAYER_HEALTH <= 0:
		print("You DIED! - Total Score: ", Globals.SCORE)
		Globals.PLAYER.modulate = Color(1, 0, 0, 1)  # Turn sprite red
		is_moving = false 
	else:
		print("Player Health: ", Globals.PLAYER_HEALTH, " | Score: ", Globals.SCORE)
	
	is_invulnerable = true # PLAYER var for invulnerability is turned on
	await get_tree().create_timer(1.0).timeout  # invulnerability lasts for 1 sec
	is_invulnerable = false #After 1sec player no longer invulnerable
	
	if (in_body):
		take_damage(1)
	
