class_name InventoryManager
extends Node

signal item_added(item: Item)
signal item_removed(item: Item)

var items := Dictionary()


func add(item: Item) -> void:
	items[item.id] = item
	item_added.emit(item)


func has(id: String) -> bool:
	return items.has(id)


func take(id: String) -> Item:
	var item: Item = items.get(id)
	if item:
		items.erase(id)
		item_removed.emit(item)
	return item
