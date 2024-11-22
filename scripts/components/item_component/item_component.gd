class_name ItemComponent
extends Node

@export var item: Item
@export var interaction_component: InteractionComponent
@export var item_root: Node3D


func _ready() -> void:
	if !interaction_component:
		push_error("Missing InteractionComponent")
		return
	if !item:
		push_error("Missing item")
		return
	if !item_root:
		push_warning("Item root not specified: ")
	interaction_component.interacted.connect(_on_interaction_component_interacted)
	interaction_component.prompt_message = "Pick up"


func _on_interaction_component_interacted() -> void:
	# TODO : add use item in item manager instead?
	if item.id == "BATTERY":
		State.add_power(10.0)
	else:
		Events.picked_up_item.emit(item)
	if item_root:
		item_root.queue_free()
