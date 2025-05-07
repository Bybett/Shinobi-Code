extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.monitoring
	self.monitorable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	await get_tree().create_timer(0.1).timeout
	self.queue_free()

func _on_area_entered(area):
	if area.has_method("take_damage"):	
		var remaining_life = area.take_damage(1)
		Globals.score += 10  # +50 for hitting
		if remaining_life <= 0:
			area.queue_free()
			Globals.score += 50  # +50 for killing
		print("Slime Health: ", area.life, " | score: ", Globals.score)
		#thing
