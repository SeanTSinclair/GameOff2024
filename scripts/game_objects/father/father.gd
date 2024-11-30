class_name Father
extends NPC


func _ready() -> void:
	super._ready()
	set_movement_target(navigation_manager.study.position)


func _on_interacted() -> void:
	if is_stopped:
		return
	emit_signal("interacted", self)
