extends Node3D

@export var battery_item: Item

@onready var item_component: ItemComponent = $ItemComponent


func _ready() -> void:
	if battery_item:
		item_component.item = battery_item
