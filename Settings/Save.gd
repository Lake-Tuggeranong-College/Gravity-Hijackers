extends Node

const SAVEFILE = "user://Settings.save"

var game_data = {}

func _ready():
	load_data()

func load_data():
	var file = FileAccess.new()
	if not file.file_exists(SAVEFILE):
		game_data = {
			"Window_mode": "Fullscreen",
			"Vsync_on": false,
			"Display_fps": false,
			"Max_fps": 0,
			"Brightness": 1,
			"Master_vol": 10,
			"Music_vol": 10,
			"SFX_vol": 10,
			"FOV": 70,
			"Mouse_sens": .1,
		}
		save_data()
	file.open(SAVEFILE, FileAccess.READ)
	game_data = file.get_var()
	file.close()

func save_data():
	var file = FileAccess.new()
	file.open(SAVEFILE, file.WRITE)
	file.store_var(game_data)
	file.close()
	
