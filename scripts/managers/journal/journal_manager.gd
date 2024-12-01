class_name JournalManager
extends Node

signal journal_event_written(time: int, message: String)
signal tasks_updated

var active_tasks := {}
var completed_tasks := {}


func _ready() -> void:
	Events.journal.connect(_on_journal)
	Events.feedback.connect(_on_feedback)
	Events.task_received.connect(_on_task_received)
	Events.task_completed.connect(_on_task_completed)


func _on_journal(message: String) -> void:
	journal_event_written.emit(State.get_current_time_in_sec(), message)


func _on_feedback(message: String) -> void:
	Events.feedback_given.emit(State.get_current_time_in_sec(), message)


func _on_task_received(task: Task) -> void:
	if active_tasks.has(task.id) || completed_tasks.has(task.id):
		return

	active_tasks[task.id] = task
	Events.journal.emit(task.task_received_message)
	tasks_updated.emit()


func _on_task_completed(task: Task) -> void:
	completed_tasks[task.id] = task
	if active_tasks.has(task.id):
		Events.journal.emit(task.task_completed_message)
		active_tasks.erase(task.id)
		tasks_updated.emit()
