extends Node

# Preload the Enemy scene
const ENEMY_SCENE = preload("res://Scenes/enemy_scene.tscn")

func spawn_enemy(ENEMY_COUNT):
	randomize()
	for i in range(ENEMY_COUNT):
		var enemy = ENEMY_SCENE.instantiate()
		var valid_position = false
		var attempts = 0
		while attempts < Globals.MAX_ATTEMPTS and not valid_position:
			enemy.position = Vector2(
				randf_range(Globals.MIN_X, Globals.MAX_X),
				randf_range(Globals.MIN_Y, Globals.MAX_Y)
			)
			valid_position = true
			for other_enemy in Globals.enemies:
				if is_instance_valid(other_enemy) and enemy.position.distance_to(other_enemy.position) < Globals.MIN_DISTANCE:
					valid_position = false
					break
			attempts += 1
		if valid_position:
			add_child(enemy)
			Globals.enemies.append(enemy)
			print("Enemy ", i, " spawned at: ", enemy.position)
		else:
			print("Warning: Could not find valid position for enemy ", i)
			enemy.queue_free()
	print("Spawned ", Globals.enemies.size(), " enemies: ", Globals.enemies)

func _ready():
	spawn_enemy(25)
