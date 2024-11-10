@tool
class_name ItemDescription
extends VBoxContainer

@export var item: Item:
	set(value):
		item = value
		_update()
	get:
		return item

@onready var name_label: Label = %NameLabel
@onready var description_label: RichTextLabel = %DescriptionLabel
@onready var inventory_item_view: InventoryItemView = %InventoryItemView


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("_update")


func _update() -> void:
	if !is_node_ready():
		return
	if !item:
		name_label.text = ""
		description_label.text = ""
		inventory_item_view.hide_item()
		hide()
		return

	name_label.text = item.name
	description_label.text = ""
	description_label.clear()
	description_label.append_text(item.description)
	inventory_item_view.show_item(item)
	show()
