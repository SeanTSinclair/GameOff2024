class_name Main
extends Node

var pause_menu_scene := preload("res://scenes/ui/pause_menu.tscn")


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("key_escape"):
		if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

		add_child(pause_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()
