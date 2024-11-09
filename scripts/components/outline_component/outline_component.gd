class_name OutlineComponent
extends Node

@export var mesh_instance: MeshInstance3D

var outline_material = preload(
	"res://scenes/components/outline_component/outline_shader_material.tres"
)


func show_outline() -> void:
	mesh_instance.material_overlay = outline_material


func hide_outline() -> void:
	mesh_instance.material_overlay = null
