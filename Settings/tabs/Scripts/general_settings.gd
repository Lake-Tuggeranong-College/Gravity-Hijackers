extends Control

func _onVsyncBtn_toggled(button_pressed):
	Save.toggle_vsync(button_pressed)

func _on_FOVSlider_value_changed(value):
	Save.update_fov(value)

func _on_MouseSens_value_changed(value):
	Save.update_mouse_sens(value)
