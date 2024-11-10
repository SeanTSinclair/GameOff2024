@tool
class_name InventoryItemView
extends Node3D

@onready var item_layer: Node3D = %ItemLayer


func show_item(item: Item) -> void:
	hide_item()

	if item.item_scene:
		var scene = item.item_scene.instantiate()
		item_layer.add_child(scene)
	else:
		push_error("Item " + item.id + " is missing scene")


func hide_item() -> void:
	for child in item_layer.get_children():
		child.queue_free()
