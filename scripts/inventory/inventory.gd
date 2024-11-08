class_name Inventory
extends Node

signal item_added(item: Item)
signal item_removed(item: Item)

const ITEM_CARD = preload("res://scenes/inventory/item_card.tscn")

var is_open: bool
var items := Dictionary()

@onready var inventory_menu: CanvasLayer = %InventoryMenu

@onready var items_flow_container: HFlowContainer = %ItemsFlowContainer


func _ready() -> void:
	if !is_open:
		inventory_menu.hide()


func open() -> void:
	inventory_menu.show()
	is_open = true


func close() -> void:
	inventory_menu.hide()
	is_open = false


func add(item: Item) -> void:
	items[item.id] = item
	update()
	item_added.emit(item)


func has(id: String) -> bool:
	return items.has(id)


func take(id: String) -> Item:
	var item: Item = items.get(id)
	if item:
		items.erase(id)
		item_removed.emit(item)
	return item


func update() -> void:
	for child in items_flow_container.get_children():
		child.queue_free()

	for id in items.keys():
		var box = ITEM_CARD.instantiate()
		box.item = items.get(id)
		box.item_clicked.connect(_on_item_clicked)
		items_flow_container.add_child(box)


func _on_close_button_pressed() -> void:
	close()


func _on_item_clicked(source: ItemCard) -> void:
	print("Item clicked: " + source.item.id + ": " + source.item.name)
