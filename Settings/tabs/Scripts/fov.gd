extends Control

@onready var fov_val = $HBoxContainer/Label2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fov_slider_value_changed(value):
	Save.update_fov(value)
	fov_val.text = str(value)
