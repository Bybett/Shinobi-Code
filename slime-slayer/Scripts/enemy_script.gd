extends Area2D
var life = 3
var attack = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Ensure the Area2D can detect overlaps
	self.monitorable = true  # Can be detected by other Area2D nodes
	self.monitoring = true   # Can detect other Area2D nodes entering it

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
