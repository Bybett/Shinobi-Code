extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.monitoring
	self.monitorable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().create_timer(0.1).timeout
	self.queue_free()

func _on_area_entered(area):
	if (area.name.begins_with("Enemy")):
		area.queue_free()
		Globals.score += 10
