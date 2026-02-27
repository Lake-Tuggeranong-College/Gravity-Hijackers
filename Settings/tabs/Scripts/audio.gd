extends Control

@onready var Master_volume_label = $"HBoxContainer/Master Volume Label" as Label
@onready var Master_volume_num = $"HBoxContainer/Master Volume Number" as Label
@onready var Master_slider = $HBoxContainer/MasterVolume as HSlider


@export_enum("Master", "Music", "SFX") var bus_name: String 

var bus_index : int = 100

func _ready():
	Master_slider.value_changed.connect(_on_value_changed)
	get_bus_by_index()
	set_name_label_text()

func set_name_label_text():
	Master_volume_label.text = str(bus_name) + " Volume"

func set_num_label_text() -> void:
	Master_volume_num.text = str(Master_slider.value * 100)

func get_bus_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

func set_slider_value():
	Master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_num_label_text()

func _on_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_index,linear_to_db(value))
	set_num_label_text()
