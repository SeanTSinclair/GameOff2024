class_name InventoryManager
extends Node

signal item_added(item: Item)
signal item_removed(item: Item)

@export_group("Inventory")
@export var items: Array[Item] = []
@export var equipped_item: Item

@export_group("Recipes")
@export var recipes: Array[Recipe] = []


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
		var old_equipped_item = equipped_item
		equipped_item = null
		Events.item_unequipped.emit(old_equipped_item)


func combine(item1: Item, item2: Item) -> bool:
	if !has_item(item1) || !has_item(item2):
		push_warning(
			(
				"Attempting to combine two items, but we don't have both: "
				+ item1.id
				+ " + "
				+ item2.id
			)
		)
		return false

	var recipe := find_recipe(item1, item2)
	if !recipe:
		return false

	return recipe.combine(self)


func find_recipe(item1: Item, item2: Item) -> Recipe:
	for recipe in recipes:
		if recipe.item1 == item1 && recipe.item2 == item2:
			return recipe
		if recipe.item2 == item1 && recipe.item1 == item2:
			return recipe
	return null


func _on_picked_up_item(item: Item) -> void:
	add(item)
