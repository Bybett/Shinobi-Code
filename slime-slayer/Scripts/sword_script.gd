extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body):
	pass
	#if (body.health):
		#body.health-= 1
	#else:
		#print("No Health Value")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().create_timer(0.5)
	self.queue_free()
