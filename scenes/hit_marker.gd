extends Control

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	self.modulate.a = max(0, self.modulate.a - (delta * 5)) # -5/s, clampi 0
	if self.modulate.a == 0:
		self.queue_free()
