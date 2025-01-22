extends Area2D

const SPEED: int = 100
var health: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_pressed("Up")):
		position.y -= SPEED * delta
	if (Input.is_action_pressed("Down")):
		position.y += SPEED * delta
	if (Input.is_action_pressed("Left")):
		position.x -= SPEED * delta
	if (Input.is_action_pressed("Right")):
		position.x += SPEED * delta
