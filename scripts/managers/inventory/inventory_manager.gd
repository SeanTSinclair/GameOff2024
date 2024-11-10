class_name InventoryManager
extends Node

signal item_added(item: Item)
signal item_removed(item: Item)

@export var items: Array[Item] = []


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
