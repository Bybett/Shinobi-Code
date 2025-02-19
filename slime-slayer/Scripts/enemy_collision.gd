extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.monitorable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player": # Check if the overlapping area is the player
		queue_free()  # Remove this enemy from the scene
