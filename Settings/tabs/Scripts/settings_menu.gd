extends Control

@onready var button: Button = $MarginContainer/VBoxContainer/Button



func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Audric's Test Stuff/testWorld.tscn")
