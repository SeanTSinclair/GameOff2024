@tool
class_name ItemCard
extends VBoxContainer

signal item_clicked(source: ItemCard)

@export var item: Item
@export var selected: bool:
	set(value):
		selected = value
		modulate = selected_color if selected else Color.WHITE

@export var selected_color: Color = Color.BLUE_VIOLET

@onready var item_button: Button = $ItemButton


func _ready() -> void:
	if !item:
		push_error("Missing item")
		return
	item_button.icon = item.inventory_texture
	item_button.tooltip_text = item.name


func _on_item_button_pressed() -> void:
	item_clicked.emit(self)
