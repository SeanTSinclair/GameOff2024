class_name JournalMenu
extends CanvasLayer

signal journal_opened
signal journal_closed

const JOURNAL_ENTRY = preload("res://scenes/ui/journal_menu/journal_entry.tscn")

@export var journal_manager: JournalManager

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

@onready var entry_container: VBoxContainer = %EntryContainer


func _ready() -> void:
	journal_manager.journal_event_written.connect(_on_journal_event_written)


func _open() -> void:
	is_closed = false
	show()
	journal_opened.emit()


func _close() -> void:
	if is_closed:
		return
	hide()
	is_closed = true
	journal_closed.emit()


func _on_journal_event_written(time: int, message: String) -> void:
	var entry = JOURNAL_ENTRY.instantiate()
	entry.set_message(time, message)
	entry_container.add_child(entry)
	Events.feedback_given.emit(time, message)


func _on_close_button_pressed() -> void:
	open = false
