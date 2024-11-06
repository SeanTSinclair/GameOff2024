class_name Inventory
extends Node

var is_open: bool
var items := Array()

@onready var inventory_ui_layer: CanvasLayer = %InventoryUILayer
@onready var rich_text_label: RichTextLabel = $InventoryUILayer/RichTextLabel


func open() -> void:
	inventory_ui_layer.show()
	is_open = true


func add(item: Item) -> void:
	items.push_back(item)
	update()


func update() -> void:
	rich_text_label.text = ""

	for item in items:
		rich_text_label.append_text(item.id + ": " + item.name)
		rich_text_label.append_text("\n")
