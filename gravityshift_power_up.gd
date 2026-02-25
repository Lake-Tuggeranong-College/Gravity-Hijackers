extends Node3D

#@onready var Player = preload("res://scenes/player.tscn")
#@onready var current_gravity = get_node("root/scenes/Player/current_gravity")
@onready var default_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var player_scene = preload("res://scenes/player.tscn")
@onready var player_scene_instance = player_scene.instantiate()
#player_node.default_gravity
@onready var gravity_multiplier = player_scene_instance.gravity_multiplier


# @onready var default_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(default_gravity)
	print(gravity_multiplier)
	add_child(player_scene_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body.name == "Player"):
		print(body.name)
		gravity_multiplier = 0.2
		queue_free()
	else:
		pass

#(body.name == "Player"):

#get_tree().current_scene.get_node("Player")

#physics/3d/default_gravity

#Player.gravity_scale = 0.2
#Player.gravity_scale = default_gravity
