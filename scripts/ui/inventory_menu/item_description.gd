@tool
class_name ItemDescription
extends VBoxContainer

signal equip_clicked(item: Item)
signal unequip_clicked(item: Item)

signal combine_clicked(item: Item)

@export var item: Item:
	set(value):
		item = value
		_update()
	get:
		return item

var current_item_is_equipped: bool:
	set(value):
		if current_item_is_equipped != value:
			current_item_is_equipped = value
			_update()

@onready var name_label: Label = %NameLabel
@onready var description_label: RichTextLabel = %DescriptionLabel
@onready var inventory_item_view: InventoryItemView = %InventoryItemView
@onready var equip_button: Button = %EquipButton
@onready var combine_button: Button = %CombineButton
@onready var sub_viewport_container: SubViewportContainer = %SubViewportContainer


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
	sub_viewport_container.visible = item.item_scene != null

	equip_button.visible = item.equippable

	equip_button.text = "Unequip" if current_item_is_equipped else "Equip"
	show()


func _on_equip_button_pressed() -> void:
	if current_item_is_equipped:
		unequip_clicked.emit(item)
	else:
		equip_clicked.emit(item)


func _on_combine_button_pressed() -> void:
	combine_clicked.emit(item)
