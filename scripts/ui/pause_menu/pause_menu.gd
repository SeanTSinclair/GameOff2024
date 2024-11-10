class_name PauseMenu
extends CanvasLayer

const MAIN_MENU := "res://scenes/ui/main_menu/main_menu.tscn"

var is_closing := false
var options_scene := preload("res://scenes/ui/options_menu/options_menu.tscn")

@onready var panel_container: PanelContainer = %PanelContainer


func _ready() -> void:
	get_tree().paused = true


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("key_escape"):
		_close()
		get_tree().root.set_input_as_handled()


func _close() -> void:
	if is_closing:
		return

	is_closing = true
	get_tree().paused = false
	queue_free()


func _on_resume_button_pressed() -> void:
	_close()


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU)


func _on_options_button_pressed() -> void:
	panel_container.visible = false

	var options_instance: OptionsMenu = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(_on_options_closed.bind(options_instance))


func _on_options_closed(instance: OptionsMenu) -> void:
	panel_container.visible = true

	instance.queue_free()
