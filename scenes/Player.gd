extends CharacterBody3D

signal health_changed(health_value)

@onready var camera = $Camera3D
@onready var anim_player = $AnimationPlayer
@onready var muzzle_flash = $Camera3D/Pistol/MuzzleFlash
@onready var raycast = $Camera3D/RayCast3D
@onready var default_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#@onready var current_gravity = default_gravity
@onready var gravity_multiplier = 1.0

var Crouchstate : bool = false
@export var ANIMATIONPLAYER : AnimationPlayer
@export_range(5, 10, 0.1) var CROUCH_SPEED : float = 7.0


@onready var ammo_display = Global.worldNode.hud.get_node("AmmoDisplay")

var health = 3
var ammo_count = 15

var reloading = false

var SPEED = 5.5
const JUMP_VELOCITY = 10.0
const LOOK_SPEED = 5 # Adjust as needed for controller comfort

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	if not is_multiplayer_authority(): return
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.current = true
	
func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event):
	if not is_multiplayer_authority(): return
	
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * .005)
		camera.rotate_x(-event.relative.y * .005)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
	
	if Input.is_action_just_pressed("reload") and !reloading and anim_player.current_animation != "shoot":
		upd_ammo(0, true) # call reload update
	
	if Input.is_action_just_pressed("shoot") and anim_player.current_animation != "shoot" and ammo_count > 0:
		upd_ammo(-1)
		
		play_shoot_effects.rpc()
		if raycast.is_colliding():
			var hit_player = raycast.get_collider()
			hit_player.receive_damage.rpc_id(hit_player.get_multiplayer_authority())

func _physics_process(delta):
	if not is_multiplayer_authority(): return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= default_gravity * gravity_multiplier * delta

	# Handle Jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("player_sprint"):
		SPEED = 8
	else:
		SPEED = 5.5

	if Input.is_action_just_pressed("player_crouch"):
		print("crouch")
		crouch()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# --- New: Handle Camera Look (Right Stick) ---
	# Get the controller stick input (Horizontal and Vertical)
	var look_dir = Input.get_vector("look_left", "look_right", "look_up", "look_down")
	
	if look_dir != Vector2.ZERO:
		# Rotate Player (Yaw) - Horizontal movement of the stick
		rotate_y(-look_dir.x * LOOK_SPEED * delta)
		
		# Rotate Camera (Pitch) - Vertical movement of the stick
		camera.rotate_x(-look_dir.y * LOOK_SPEED * delta)
		
		# Clamp camera pitch rotation (same as your mouse look code)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

	if anim_player.current_animation == "shoot":
		pass
	elif input_dir != Vector2.ZERO and is_on_floor():
		anim_player.play("move")
	else:
		anim_player.play("idle")

	move_and_slide()



@rpc("call_local")
func play_shoot_effects():
	anim_player.stop()
	anim_player.play("shoot")
	muzzle_flash.restart()
	muzzle_flash.emitting = true

@rpc("any_peer")
func receive_damage():
	health -= 1
	if health <= 0:
		health = 3
		position = Vector3.ZERO
	health_changed.emit(health)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "shoot":
		anim_player.play("idle")

func upd_ammo(num: int, reload: bool = false):
	if reload:
		reloading = true
		Global.worldNode.hud.get_node("Crosshair").hide()
		await get_tree().create_timer(1).timeout
		Global.worldNode.hud.get_node("Crosshair").show()
		ammo_count = 15
		reloading = false
	else:
		ammo_count += num
	ammo_display.text = "%d / 15" % ammo_count

func crouch():
	if Crouchstate == true:
		if Input.is_action_just_pressed("player_crouch"):
			anim_player.play("Crouch", -1, -CROUCH_SPEED, true)
			Crouchstate = false
	elif Crouchstate == false:
		if Input.is_action_just_pressed("player_crouch"):
			anim_player.play("Crouch", -1, CROUCH_SPEED)
			Crouchstate = true
	
