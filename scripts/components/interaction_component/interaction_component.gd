class_name InteractionComponent
extends Area3D

signal interacted
signal entered
signal exited

@export var enabled = true
@export var prompt_message: String = "Interact"
@export var prompt_action: String = "interact"


func get_prompt():
	if not enabled:
		return ""

	var key_name := ""
	for action in InputMap.action_get_events(prompt_action):
		if action is InputEventKey:
			key_name = action.as_text_physical_keycode()
			break
		elif action is InputEventMouseButton:
			key_name = action.as_text()
	return prompt_message + "\n[" + key_name + "]"


func interact() -> void:
	if not enabled:
		return

	interacted.emit()


func enter() -> void:
	if not enabled:
		return

	entered.emit()


func exit() -> void:
	if not enabled:
		return

	exited.emit()
