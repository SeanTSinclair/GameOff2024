extends CanvasLayer

const JOURNAL_ENTRY = preload("res://scenes/ui/journal_menu/journal_entry.tscn")

@onready var v_box_container: VBoxContainer = $VBoxContainer


func _ready() -> void:
	Events.feedback_given.connect(_on_feedback_given)


func _on_feedback_given(time: int, message: String) -> void:
	var entry = JOURNAL_ENTRY.instantiate()
	entry.set_message(time, message)
	v_box_container.add_child(entry)
	entry.start_free_timer()
