extends Control

@onready var option_button: OptionButton = $HBoxContainer/OptionButton as OptionButton

const WINDOW_MODE_ARRAY : Array[String] = [
	"Full_screen",
	"Window Mode",
	"Borderless Window",
	"Borderless Fullscreen",
]
