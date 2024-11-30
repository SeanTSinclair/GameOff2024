extends Node3D


func _on_interaction_component_interacted() -> void:
	get_node("/root/Main").switch_to_final_scene()
