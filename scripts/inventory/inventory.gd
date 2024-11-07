class_name Inventory
extends Node

const ITEM_CARD = preload("res://scenes/inventory/item_card.tscn")

var is_open: bool
var items := Array()

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
	items.push_back(item)
	update()


func update() -> void:
	for child in items_flow_container.get_children():
		child.queue_free()

	for item in items:
		var box = ITEM_CARD.instantiate()
		box.item = item
		box.item_clicked.connect(_on_item_clicked)
		items_flow_container.add_child(box)


func _on_close_button_pressed() -> void:
	close()


func _on_item_clicked(source: ItemCard) -> void:
	print("Item clicked: " + source.item.id + ": " + source.item.name)
