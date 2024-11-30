extends Node3D

var has_interacted: bool = false

@onready var interaction_component: InteractionComponent = $InteractionComponent


func _ready() -> void:
	Events.secret_message_found.connect(_on_secret_message_found)
	interaction_component.interacted.connect(_on_interacted)


func _on_secret_message_found(id: String) -> void:
	if id == "secret_text_book":
		interaction_component.enabled = true


func _on_interacted() -> void:
	if has_interacted:
		return
	has_interacted = true
	interaction_component.enabled = false
	Events.secret_book_interacted_with.emit()
