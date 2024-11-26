class_name NPC
extends Node3D

@export var move_speed: float = 0.4

var navigation_manager: NavigationManager


func _ready() -> void:
	navigation_manager = get_tree().get_first_node_in_group("navigation_manager")
