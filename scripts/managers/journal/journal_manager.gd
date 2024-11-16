class_name JournalManager
extends Node

signal journal_event_written(time: int, message: String)

@onready var start_time: int = Time.get_ticks_msec() / 1000


func _ready() -> void:
	Events.journal.connect(_on_journal)


func _on_journal(message: String) -> void:
	journal_event_written.emit(get_current_time_in_sec(), message)


func get_current_time_in_sec() -> int:
	return (Time.get_ticks_msec() / 1000) - start_time
