extends AudioStreamPlayer


func _on_character_body_3d_footstep() -> void:
	stream.loop = false
	play()
