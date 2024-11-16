class_name JournalEntry
extends RichTextLabel

@onready var timer: Timer = $Timer


func set_message(time: int, message: String) -> void:
	text = ""
	push_color(Color.DARK_GRAY)
	append_text(_format_time(time) + ": ")
	pop()
	append_text(message)


func start_free_timer() -> void:
	timer.start()


func _format_time(time: int) -> String:
	var minutes: int = time / 60
	var seconds: int = time % 60
	return "%02d:%02d" % [minutes, seconds]


func _on_timer_timeout() -> void:
	queue_free()
