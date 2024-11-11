extends Node3D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("key_escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
