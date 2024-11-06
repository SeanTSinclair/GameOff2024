class_name MainMenu
extends CanvasLayer

var main_scene := preload("res://scenes/test_level_00.tscn")
var options_scene := preload("res://scenes/ui/options_menu.tscn")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_options_button_pressed() -> void:
	var options_instance: OptionsMenu = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(_on_options_closed.bind(options_instance))


func _on_options_closed(instance: OptionsMenu) -> void:
	instance.queue_free()
