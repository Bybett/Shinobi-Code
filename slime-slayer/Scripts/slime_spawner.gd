extends Node2D

@export var slime_count: int = 2

# Tests if can spawn one slime up to 10 different places
const max_attempts: int = 10

#Minimum radius a slime can spawn from an entity
const min_radius: int = 300

func _ready():
	spawn_slime(slime_count)

#Spawns a slime checking if there is a available spot to spawn
func spawn_slime(count):
	randomize()
	
	# Loops for total amount of SLIMES wanted to spawned
	for i in range(count):
		var slime_position: Vector2
		var valid_position = false #assumes there is no position to spawn
		var attempts = 0
		
		#Loop attempts to find valid position, breaks if there is valid position
		while attempts < max_attempts and not valid_position:
			slime_position = Vector2( #grab random position
				randf_range(Globals.MIN_X, Globals.MAX_X),
				randf_range(Globals.MIN_Y, Globals.MAX_Y)
			) 
			#DEBUG
			#print(slime_position)
			valid_position = true #assumes position is valid
			
			# Check distance to the player
			if is_instance_valid(Globals.PLAYER):
				var distance_to_player = slime_position.distance_to(Globals.PLAYER.position)
				#DEBUG
				#print(distance_to_player)
				
				if distance_to_player < min_radius:
					valid_position = false #not enough distance from player returns invalid
					#DEBUG
					#print("SLIME couldn't spawn due to PLAYER position")
			
			# Check distance to all entities, excluding player
			for other_entity in Globals.ENTITIES:
				if is_instance_valid(other_entity):
					var distance = slime_position.distance_to(other_entity.position)
					
					#finds one entity that fails test
					if distance < min_radius:
						valid_position = false
						# Debug: Print which entity caused the invalid position
						#print("Couldn't spawn due to: ", other_entity)
						break #exits loop
				else:
					pass 
					# #DEBUG: Warn if an invalid entity is found
					#print("Warning: Invalid entity found in ENTITIES: ", other_entity)
			
			attempts += 1 #if position doesn't pass all tests try again
		
		#If position passes all tests, spawn enemy
		if valid_position:
			var slime = Globals.SLIME_SCENE.instantiate()
			slime.position = slime_position
			add_child(slime)
			Globals.ENTITIES.append(slime)
			#DEBUG
			#print("Enemy ", i, " spawned at: ", slime.position)
		else:
			#DEBUG
			#print("Warning: Could not find valid position for enemy ", i)
			#slime.queue_free() #removes SLIME istantiated
			pass
	#DEBUG
	#print("Spawned ", Globals.ENTITIES.size(), " enemies: ", Globals.ENTITIES)
