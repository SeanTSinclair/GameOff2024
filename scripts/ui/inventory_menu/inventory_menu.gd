class_name InventoryMenu
extends CanvasLayer

signal inventory_opened
signal inventory_closed

const ITEM_CARD = preload("res://scenes/ui/inventory_menu/item_card.tscn")

@export var inventory_manager: InventoryManager

var is_closed := false

var open: bool:
	set(value):
		open = value
		if open:
			_open()
		else:
			_close()
	get:
		return open

@onready var item_description: ItemDescription = %ItemDescription
@onready var items_flow_container: HFlowContainer = %ItemsFlowContainer


func _ready() -> void:
	Events.item_equipped.connect(_on_item_equipped)
	Events.item_unequipped.connect(_on_item_unequipped)
	if inventory_manager:
		inventory_manager.item_added.connect(_on_item_added)
		inventory_manager.item_removed.connect(_on_item_removed)
		update()
	else:
		push_error("Missing InventoryManager")


func _open() -> void:
	is_closed = false
	show()
	inventory_opened.emit()


func _close() -> void:
	if is_closed:
		return
	hide()
	is_closed = true
	inventory_closed.emit()


func update() -> void:
	for child in items_flow_container.get_children():
		child.queue_free()

	var selected_item = item_description.item
	item_description.item = null

	for item in inventory_manager.items:
		var box = ITEM_CARD.instantiate()
		box.item = item
		box.item_clicked.connect(_on_item_clicked)
		box.selected = box.item == selected_item
		item_description.item = selected_item
		items_flow_container.add_child(box)

	item_description.current_item_is_equipped = selected_item == inventory_manager.equipped_item


func _on_item_clicked(source: ItemCard) -> void:
	print("Item clicked: " + source.item.id + ": " + source.item.name)
	if source.selected:
		source.selected = false
		item_description.item = null
	else:
		source.selected = true
		item_description.item = source.item
		for child in items_flow_container.get_children():
			if child != source:
				child.selected = false

	item_description.current_item_is_equipped = inventory_manager.equipped_item == source.item


func _on_item_added(_item: Item) -> void:
	update()


func _on_item_removed(item: Item) -> void:
	if item_description.item && item_description.item.id == item.id:
		item_description.item = null
	update()


func _on_item_equipped(_item: Item) -> void:
	update()


func _on_item_unequipped(_item: Item) -> void:
	update()


func _on_close_button_pressed() -> void:
	open = false


func _on_item_description_equip_clicked(item: Item) -> void:
	inventory_manager.equip(item)


func _on_item_description_unequip_clicked(_item: Item) -> void:
	inventory_manager.unequip()
