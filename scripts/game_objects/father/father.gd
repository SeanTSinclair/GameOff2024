class_name Father
extends NPC


func _on_interacted() -> void:
	if is_stopped:
		return
	emit_signal("interacted", self)
