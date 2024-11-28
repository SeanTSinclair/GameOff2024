extends NPC


func _process(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		get_tree().create_timer(0.5).timeout.connect(
			teleport_to_node.bind(navigation_manager.kitchen)
		)


func _on_interacted() -> void:
	if is_stopped:
		return
	emit_signal("interacted", self)
