extends CanvasLayer

var gui_componenets = [
	"res://Settings/tabs/Video.tscn"
]

var resolutions = {
	"3840x2160": Vector2i(3840, 2160),
	"2560x1440": Vector2i(2560, 1440),
	"1920x1080": Vector2i(1920, 1080),
	"1366x768": Vector2i(1366, 768),
	"1280x720": Vector2i(1280, 720),
	"1440x900": Vector2i(1440, 900),
	"1600x900": Vector2i(1600, 900),
	"1024x600": Vector2i(1024, 600),
	"800x600": Vector2i(800, 600),
}

func _ready():
	for i in gui_componenets:
		var new_scene = load(i).instantiate()
		add_child(new_scene)
		new_scene.hide()
