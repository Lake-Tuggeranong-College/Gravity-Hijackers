extends Node3D

@onready var Player = get_node("/root/scenes/player/Player")
#@onready var current_gravity = get_node("root/scenes/Player/current_gravity")
@onready var default_gravity = get_node("root/scenes/Player/default_gravity")
@onready var gravity_multiplier = get_node("root/scenes/Player/gravity_multiplier")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(default_gravity)
	print(gravity_multiplier)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body.name == "Player"):
		print(Player.name)
		gravity_multiplier = 0.2
		queue_free()
	else:
		pass

#(body.name == "Player"):

#get_tree().current_scene.get_node("Player")

#physics/3d/default_gravity

#Player.gravity_scale = 0.2
#Player.gravity_scale = default_gravity
