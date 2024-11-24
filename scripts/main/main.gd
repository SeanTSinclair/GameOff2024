class_name Main
extends Node

enum MainStates { ACTIVE, INVENTORY_MENU, JOURNAL_MENU, PAUSE_MENU }

const FIND_BLACKLIGHT = preload("res://resources/tasks/find_blacklight.tres")

var state: MainStates = MainStates.ACTIVE

@onready var world_layer: Node = %WorldLayer
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var inventory_menu: InventoryMenu = %InventoryMenu
@onready var journal_menu: JournalMenu = %JournalMenu
@onready var scene_anim_player: AnimationPlayer = %WorldLayer/TestLevel00/AnimationPlayer
@onready var father: Father = $WorldLayer/TestLevel00/Mansion/Characters/Father
@onready var player: CharacterBody3D = $WorldLayer/TestLevel00/Player


func _ready():
	State.reset()
	# Trigger the first task - Should be removed when we have an actual first task
	scene_anim_player.play("Intro")

	call_deferred("_initial_tasks")
	father.set_player(player)


func _initial_tasks() -> void:
	Events.task_received.emit(FIND_BLACKLIGHT)


func _input(event: InputEvent) -> void:
	match state:
		MainStates.ACTIVE:
			_handle_active_input(event)
		MainStates.INVENTORY_MENU:
			_handle_inventory_input(event)
		MainStates.JOURNAL_MENU:
			_handle_journal_menu(event)
		MainStates.PAUSE_MENU:
			_handle_pause_input(event)


func _handle_active_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_escape"):
		open_pause_menu()
	elif event.is_action_pressed("inventory"):
		open_inventory_menu()
	elif event.is_action_pressed("journal"):
		open_journal_menu()


func _handle_inventory_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_escape") or event.is_action_pressed("inventory"):
		close_inventory_menu()


func _handle_journal_menu(event: InputEvent) -> void:
	if event.is_action_pressed("key_escape") or event.is_action_pressed("journal"):
		close_journal_menu()


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


func open_journal_menu() -> void:
	get_tree().paused = true
	state = MainStates.JOURNAL_MENU
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	journal_menu.open = true


func close_journal_menu() -> void:
	journal_menu.open = false


func menu_closed() -> void:
	state = MainStates.ACTIVE
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	call_deferred("signal_unpaused")


func signal_unpaused() -> void:
	Events.game_unpaused.emit()


func _on_inventory_menu_inventory_closed() -> void:
	menu_closed()


func _on_pause_menu_pause_menu_closed() -> void:
	menu_closed()


func _on_journal_menu_journal_closed() -> void:
	menu_closed()
