extends Node3D


signal speed_pickup_pickedup(int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: CharacterBody3D) -> void:
	if is_multiplayer_authority():
		if body.name == "Player":
			speed_pickup_pickedup.emit(2)
			queue_free()
	else:
		pass # Maybe "queue_free"?
