class_name InventoryMenu
extends CanvasLayer

signal inventory_opened
signal inventory_closed

const ITEM_CARD = preload("res://scenes/ui/inventory_menu/item_card.tscn")

@export var inventory_manager: InventoryManager

var open: bool:
	set(value):
		open = value
		if open:
			_open()
		else:
			_close()
	get:
		return open

@onready var items_flow_container: HFlowContainer = %ItemsFlowContainer


func _ready() -> void:
	if inventory_manager:
		inventory_manager.item_added.connect(_on_item_added)
		inventory_manager.item_removed.connect(_on_item_removed)
	else:
		push_error("Missing InventoryManager")


func _open() -> void:
	show()
	inventory_opened.emit()


func _close() -> void:
	hide()
	inventory_closed.emit()


func update() -> void:
	for child in items_flow_container.get_children():
		child.queue_free()

	var items = inventory_manager.items.values()

	for item in items:
		var box = ITEM_CARD.instantiate()
		box.item = item
		box.item_clicked.connect(_on_item_clicked)
		items_flow_container.add_child(box)


func _on_item_clicked(source: ItemCard) -> void:
	print("Item clicked: " + source.item.id + ": " + source.item.name)


func _on_item_added(_item: Item) -> void:
	update()


func _on_item_removed(_item: Item) -> void:
	update()


func _on_close_button_pressed() -> void:
	open = false
