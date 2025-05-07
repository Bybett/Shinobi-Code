extends Node2D

func _ready():
	spawn_enemy(25)

func spawn_enemy(ENEMY_COUNT):
	randomize()
	for i in range(ENEMY_COUNT):
		var enemy = Globals.ENEMY_SCENE.instantiate()
		var valid_position = false
		var attempts = 0
		while attempts < Globals.MAX_ATTEMPTS and not valid_position:
			enemy.position = Vector2(
				randf_range(Globals.MIN_X, Globals.MAX_X),
				randf_range(Globals.MIN_Y, Globals.MAX_Y)
			)
			valid_position = true
			
			# Check distance to the player
			if is_instance_valid(Globals.PLAYER):
				var distance_to_player = enemy.position.distance_to(Globals.PLAYER.position)
				if distance_to_player < Globals.MIN_DISTANCE:
					valid_position = false
					#print("Invalid position for enemy ", i, " due to player at ", Globals.PLAYER.position, " | Distance: ", distance_to_player)
			else:
				pass #print("Warning: Player instance is invalid")
			
			# Check distance to all entities, excluding player
			for other_enemy in Globals.ENTITIES:
				if is_instance_valid(other_enemy):
					var distance = enemy.position.distance_to(other_enemy.position)
					if distance < Globals.MIN_DISTANCE:
						valid_position = false
						# Debug: Print which entity caused the invalid position
						#print("Invalid position for enemy ", i, " due to entity at ", other_enemy.position, " | Distance: ", distance)
						break
				else:
					pass # Debug: Warn if an invalid entity is found
					#print("Warning: Invalid entity found in ENTITIES: ", other_enemy)
			
			attempts += 1
		if valid_position:
			add_child(enemy)
			Globals.ENTITIES.append(enemy)
			#print("Enemy ", i, " spawned at: ", enemy.position)
		else:
			#print("Warning: Could not find valid position for enemy ", i)
			enemy.queue_free()
	#print("Spawned ", Globals.ENTITIES.size(), " enemies: ", Globals.ENTITIES)
