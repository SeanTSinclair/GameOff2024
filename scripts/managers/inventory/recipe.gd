class_name Recipe
extends Resource

@export var item1: Item
@export var item2: Item

@export var produces: Item


func inventory_has_required_items(inventory_manager: InventoryManager) -> bool:
	return inventory_manager.has_item(item1) && inventory_manager.has_item(item2)


# Combine items in recipe. Override if you want to create other effects
func combine(inventory_manager: InventoryManager) -> bool:
	if !inventory_has_required_items(inventory_manager):
		return false

	if produces:
		inventory_manager.take(item1)
		inventory_manager.take(item2)
		inventory_manager.add(produces)
		return true
	return false
