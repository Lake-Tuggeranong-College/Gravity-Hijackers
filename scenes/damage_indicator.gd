extends Node3D
@onready var label = $Label3D

func _on_timer_timeout() -> void:
	self.queue_free()

func _physics_process(delta: float) -> void:
	self.global_position.y += delta
	# max acts as a clamp for specifically min vals
	# font size and outline must always be greater than 0 otherwise exception is raised
	label.font_size = max(label.font_size - 2, 1)
	label.outline_size = max(label.outline_size - 1, 1)
