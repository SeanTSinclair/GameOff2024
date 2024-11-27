extends Node3D

@export var key_id: String

@onready var interaction_component: InteractionComponent = $InteractionComponent


func _ready():
	interaction_component.interacted.connect(_on_interacted)


func _on_interacted() -> void:
	State.add_key_found(key_id)
