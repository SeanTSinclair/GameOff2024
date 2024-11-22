class_name KeybindsMenu
extends CanvasLayer

signal back_pressed

@onready var back_button: Button = %BackButton
@onready var reset_button: Button = %ResetButton
@onready var keybinds_manager: KeybindsManager = %KeybindsManager


func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)
	reset_button.pressed.connect(_on_reset_button_pressed)


func _on_back_button_pressed() -> void:
	back_pressed.emit()
	queue_free()


func _on_reset_button_pressed() -> void:
	InputMap.load_from_project_settings()
	keybinds_manager.create_action_list()
