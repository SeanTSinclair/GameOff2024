class_name MainMenu
extends CanvasLayer

var main_scene := preload("res://scenes/test_level_00.tscn")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)


func _on_options_button_pressed() -> void:
	pass  # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
