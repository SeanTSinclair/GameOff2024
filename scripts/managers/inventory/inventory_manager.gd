class_name InventoryManager
extends Node

signal item_added(item: Item)
signal item_removed(item: Item)

@export var items: Array[Item] = []
@export var equipped_item: Item


func _ready() -> void:
	Events.picked_up_item.connect(_on_picked_up_item)


func add(item: Item) -> void:
	if has_item(item):
		push_warning("InventoryManager: Adding item that we already have in inventory: " + item.id)
		return

	items.push_back(item)
	item_added.emit(item)


func has_id(id: String) -> bool:
	return items.any(func(item): return item.id == id)


func has_item(item: Item) -> bool:
	return items.any(func(inventory_item): return inventory_item.id == item.id)


func get_by_id(id: String) -> Item:
	for item in items:
		if item.id == id:
			return item
	return null


func take_by_id(id: String) -> Item:
	var item := get_by_id(id)

	if !id:
		push_warning("InventoryManager: Taking item that we don't have in inventory: " + id)
		return null

	return take(item)


func take(item: Item) -> Item:
	var index = items.find(item, 0)
	if index < 0:
		push_warning("InventoryManager: Taking item that we don't have in inventory: " + item.id)

	var item_taken = items.pop_at(index)
	item_removed.emit(item_taken)
	return item_taken


func equip(item: Item) -> void:
	if equipped_item != null && equipped_item != item:
		unequip()
	equipped_item = item
	Events.item_equipped.emit(item)


func unequip() -> void:
	if equipped_item != null:
		equipped_item = null
		Events.item_unequipped.emit(equipped_item)


func _on_picked_up_item(item: Item) -> void:
	add(item)
