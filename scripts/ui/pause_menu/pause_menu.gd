class_name PauseMenu
extends CanvasLayer

signal pause_menu_opened
signal pause_menu_closed

const MAIN_MENU := "res://scenes/ui/main_menu/main_menu.tscn"

var is_closed := false
var options_scene := preload("res://scenes/ui/options_menu/options_menu.tscn")

var open: bool:
	set(value):
		open = value
		if open:
			_open()
		else:
			_close()
	get:
		return open

@onready var panel_container: PanelContainer = %PanelContainer


func _open() -> void:
	is_closed = false
	show()
	pause_menu_opened.emit()


func _close() -> void:
	if is_closed:
		return
	hide()
	is_closed = true
	pause_menu_closed.emit()


func _on_resume_button_pressed() -> void:
	open = false


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
