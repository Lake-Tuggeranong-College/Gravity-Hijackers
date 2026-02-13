extends Control
class_name RebindButton

@onready var label: Label = $HBoxContainer/Label as Label
@onready var button: Button = $HBoxContainer/Button as Button

@export var action_name: String = "Shoot"

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_input()
	

func set_action_name():
	label.text = "Unassigned"

	match action_name:
		"shoot":
			label.text = "Shoot"
		"left":
			label.text = "Move Left"
		"right":
			label.text = "Move Right"
		"up":
			label.text = "Move forward"
		"down":
			label.text = "Move backwards"
		"player_jump":
			label.text = "Jump"
		"player_sprint":
			label.text = "Sprint"
		"player_crouch":
			label.text = "Crouch"


func set_text_for_input() -> void:
	var action_events = InputMap.action_get_events(action_name)
	if action_events.size() > 0:
		var action_event = action_events[0]
		var input_text = get_input_text(action_event)
		button.text = input_text
	else:
		button.text = "Unassigned"

func get_input_text(event: InputEvent) -> String:
	if event is InputEventKey and event.keycode != 0:
		return OS.get_keycode_string(event.keycode)
	elif event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				return "Mouse Left"
			MOUSE_BUTTON_RIGHT:
				return "Mouse Right"
			MOUSE_BUTTON_MIDDLE:
				return "Mouse Middle"
			MOUSE_BUTTON_WHEEL_UP:
				return "Wheel Up"
			MOUSE_BUTTON_WHEEL_DOWN:
				return "Wheel Down"
			_:
				return "Mouse " + str(event.button_index)
	return "Unassigned"

func _on_button_toggled(button_pressed):
	if button_pressed:
		button.text = "Press any key..."
		set_process_unhandled_key_input(button_pressed)
		
		# Disable toggling on other buttons in the group
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i is RebindButton:  # Ensure it's a RebindButton
				if i.action_name != self.action_name:
					i.button.toggle_mode = false
					i.set_process_unhandled_key_input(false)
	else:
		# Enable toggling again when button is not pressed
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i is RebindButton:  # Ensure it's a RebindButton
				if i.action_name != self.action_name:
					i.button.toggle_mode = true
					i.set_process_unhandled_key_input(false)
			
		set_text_for_input()

func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false

func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_input()
	set_action_name()
