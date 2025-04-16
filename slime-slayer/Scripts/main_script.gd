extends Node

#@onready var slime_spawner = get_node("res://Scripts/slime_spawner.gd")

@onready var player = $Player
@onready var slime_scene: PackedScene = load("res://Scenes/enemy_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.position = Vector2(100, 100)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Slime spawning
	await get_tree().create_timer(1).timeout
	pass
