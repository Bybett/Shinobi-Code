extends Node

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.position = Vector2(100, 100)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
