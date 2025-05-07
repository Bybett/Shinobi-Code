extends Area2D

@onready var sprite = $Sprite2D

@export var SPEED: int
@export var ATTACK_DISTANCE:int
@export var direction: Vector2
@export var sword_swipe_scene: PackedScene

var is_moving = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#direction = Vector2.RIGHT
	#pass # Replace with function body.
	global_position = Vector2(102, 100)
	Globals.PLAYER = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_moving:
		if (Input.is_action_pressed("Up")):
			position.y -= SPEED * delta
			direction = Vector2.UP
		if (Input.is_action_pressed("Down")):
			position.y += SPEED * delta
			direction = Vector2.DOWN
		if (Input.is_action_pressed("Left")):
			position.x -= SPEED * delta
			direction = Vector2.LEFT
		if (Input.is_action_pressed("Right")):
			position.x += SPEED * delta
			direction = Vector2.RIGHT
		if (Input.is_action_just_released("Space")):
			if sword_swipe_scene:
				var sword_swipe = sword_swipe_scene.instantiate()
				sword_swipe.position = (direction * ATTACK_DISTANCE) * 2
				if (direction == Vector2.UP):
					sword_swipe.rotation_degrees = -90
				elif (direction == Vector2.DOWN):
					sword_swipe.rotation_degrees = 90
				add_child(sword_swipe)
			else:
				print("No sword_swipe_scene")
			
			
func _on_area_entered(area):
	if area.has_method("give_damage"):
		area.give_damage()
		if Globals.HERO_HEALTH <= 0:
			print("You DIED! - Total Score: ", Globals.score)
			sprite.modulate = Color(1, 0, 0, 1)
			is_moving = false
			return
		print("Hero Health: ", Globals.HERO_HEALTH, " | Score: ", Globals.score)
	


func _on_timer_timeout() -> void:
	pass # Replace with function body.
