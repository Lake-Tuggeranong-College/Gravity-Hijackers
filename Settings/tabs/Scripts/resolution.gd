extends Control



@onready var resolutions_option_button = $HBoxContainer/OptionButton 

var resolutions = {
	"3840x2160": Vector2i(3840, 2160),
	"2560x1440": Vector2i(2560, 1440),
	"1920x1080": Vector2i(1920, 1080),
	"1366x768": Vector2i(1366, 768),
	"1280x720": Vector2i(1280, 720),
	"1440x900": Vector2i(1440, 900),
	"1600x900": Vector2i(1600, 900),
	"1024x600": Vector2i(1024, 600),
	"800x600": Vector2i(800, 600)
}

func _ready() -> void:
	add_resolutions()

func add_resolutions():
	for r in resolutions:
		resolutions_option_button.add_item(r)

func update_button_values():
	var window_size_string = str(get_window().size.x, "x", get_window().size.y)
	var resolutions_index = resolutions.keys().find(window_size_string)
	resolutions_option_button.selected = resolutions_index

func _on_option_button_item_selected(index):
	var key = resolutions_option_button.get_item_text(index)
	get_window().set_size(resolutions[key])
	
