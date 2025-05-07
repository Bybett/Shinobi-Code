extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.monitoring
	self.monitorable
	# Connect the body_entered signal to handle collisions with CharacterBody2D
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	await get_tree().create_timer(0.1).timeout
	self.queue_free()
		
func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		var remaining_life = body.take_damage(1)
		Globals.score += 10  # +10 for hitting
		if remaining_life <= 0:
			body.queue_free()
			Globals.score += 50  # +50 for killing
		print("Slime Health: ", body.life, " | Score: ", Globals.score)
