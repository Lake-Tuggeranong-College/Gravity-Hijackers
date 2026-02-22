extends Control

@onready var resolutions_option_button = $OptionButton


func _ready() -> void:
	add_resolutions()

func add_resolutions():
	for r in GuiAutoload.resolutions:
		resolutions_option_button.add_item(r)
		

func update_button_values():
	var window_size_string = str(get_window().size.x, "x", get_window().size.y)
	var resolutions_index = GuiAutoload.resolutions.keys().find(window_size_string)
	resolutions_option_button.selected = resolutions_index

func _on_option_button_item_selected(index):
	var key = resolutions_option_button.get_item_text()
	get_window().set_size(GuiAutoload.resolutions[key])
	
