class_name Main
extends Node

enum MainStates { ACTIVE, INVENTORY_MENU, PAUSE_MENU }

#var pause_menu_scene := preload("res://scenes/ui/pause_menu/pause_menu.tscn")

var state: MainStates = MainStates.ACTIVE

@onready var world_layer: Node = %WorldLayer
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var inventory_menu: InventoryMenu = %InventoryMenu


func _input(event: InputEvent) -> void:
	match state:
		MainStates.ACTIVE:
			_handle_active_input(event)
		MainStates.INVENTORY_MENU:
			_handle_inventory_input(event)
		MainStates.PAUSE_MENU:
			_handle_pause_input(event)


func _handle_active_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_escape"):
		open_pause_menu()
	elif event.is_action_pressed("inventory"):
		open_inventory_menu()


func _handle_inventory_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_escape") or event.is_action_pressed("inventory"):
		close_inventory_menu()


func _handle_pause_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_escape"):
		close_pause_menu()


func open_pause_menu() -> void:
	get_tree().paused = true
	state = MainStates.PAUSE_MENU
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pause_menu.open = true


func close_pause_menu() -> void:
	pause_menu.open = false


func open_inventory_menu() -> void:
	get_tree().paused = true
	state = MainStates.INVENTORY_MENU
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	inventory_menu.open = true


func close_inventory_menu() -> void:
	inventory_menu.open = false


func menu_closed() -> void:
	state = MainStates.ACTIVE
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false


func _on_inventory_menu_inventory_closed() -> void:
	menu_closed()


func _on_pause_menu_pause_menu_closed() -> void:
	menu_closed()
