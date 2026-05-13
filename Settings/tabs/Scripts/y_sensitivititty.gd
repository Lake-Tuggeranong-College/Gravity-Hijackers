extends Control

@onready var sens_val: Label = $HBoxContainer/Sens_Val



func _on_h_slider_value_changed(value: float):
	Save.Y_update_mouse_sens(value/10)
	sens_val.text = str(value*200)
