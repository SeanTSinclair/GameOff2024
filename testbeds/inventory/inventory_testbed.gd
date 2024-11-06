extends Node2D

@export var test_item_1: Item
@export var test_item_2: Item

@onready var panel_canvas_layer: CanvasLayer = $PanelCanvasLayer
@onready var inventory: Inventory = $Inventory


func _on_open_button_pressed() -> void:
	inventory.open()


func _on_add_item_1_button_pressed() -> void:
	inventory.add(test_item_1)


func _on_add_item_2_button_pressed() -> void:
	inventory.add(test_item_2)
