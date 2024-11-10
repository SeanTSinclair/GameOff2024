extends Node2D

@onready var panel_canvas_layer: CanvasLayer = $PanelCanvasLayer
@onready var inventory_menu: InventoryMenu = $InventoryMenu
@onready var inventory_manager: InventoryManager = $InventoryManager


func _on_open_button_pressed() -> void:
	inventory_menu.open = true


func _on_item_card_item_clicked(source: ItemCard) -> void:
	if inventory_manager.has_item(source.item):
		inventory_manager.take(source.item)
	else:
		inventory_manager.add(source.item)


func _on_inventory_manager_item_added(item: Item) -> void:
	print("Item added: " + item.id + ": " + item.name)


func _on_inventory_manager_item_removed(item: Item) -> void:
	print("Item removed: " + item.id + ": " + item.name)
