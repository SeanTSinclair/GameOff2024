extends Node2D

@onready var panel_canvas_layer: CanvasLayer = $PanelCanvasLayer
@onready var inventory: Inventory = $Inventory


func _on_open_button_pressed() -> void:
	inventory.open()


func _on_item_card_item_clicked(source: ItemCard) -> void:
	inventory.add(source.item)
	source.queue_free()
