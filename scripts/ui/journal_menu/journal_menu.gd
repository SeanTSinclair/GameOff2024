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

@onready var notes: ScrollContainer = %Notes
@onready var entry_container: VBoxContainer = %EntryContainer
@onready var tasks: ScrollContainer = %Tasks
@onready var task_container: VBoxContainer = %TaskContainer

@onready var current_label: Label = %CurrentLabel


func _ready() -> void:
	journal_manager.journal_event_written.connect(_on_journal_event_written)
	journal_manager.tasks_updated.connect(_on_task_updated)


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


func _on_notes_button_pressed() -> void:
	current_label.text = "Notes"
	notes.visible = true
	tasks.visible = false


func _on_tasks_button_pressed() -> void:
	current_label.text = "Tasks"
	notes.visible = false
	tasks.visible = true


func _on_task_updated() -> void:
	for node in task_container.get_children():
		node.queue_free()
	for task_name in journal_manager.active_tasks:
		var task = journal_manager.active_tasks[task_name]
		if task is Task:
			var label = Label.new()
			label.text = task.description
			task_container.add_child(label)
