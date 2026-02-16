extends Node3D

@onready var Player = get_node("/root/player/Player")
@onready var current_gravity = get_node("root/Player/current_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		print(Player.name)
		Player.gravity_scale = 0.2
		queue_free()

#(body.name == "Player"):

#get_tree().current_scene.get_node("Player")

#physics/3d/default_gravity
