class_name MainMenu
extends CanvasLayer

var main_scene := preload("res://scenes/main/main.tscn")
var options_scene := preload("res://scenes/ui/options_menu/options_menu.tscn")

@onready var panel_container: PanelContainer = %PanelContainer


func _enter_tree() -> void:
	SoundManager.play_bgm("BGM")


func _ready() -> void:
	State.reset()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_options_button_pressed() -> void:
	panel_container.visible = false

	var options_instance: OptionsMenu = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(_on_options_closed.bind(options_instance))


func _on_options_closed(instance: OptionsMenu) -> void:
	panel_container.visible = true

	instance.queue_free()


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/credits/credits.tscn")
