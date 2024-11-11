class_name OutlineComponent
extends Node

@export var mesh_instance: MeshInstance3D
@export var interaction_component: InteractionComponent

var outline_material = preload(
	"res://scenes/components/outline_component/outline_shader_material.tres"
)


func _ready() -> void:
	if interaction_component:
		interaction_component.entered.connect(show_outline)
		interaction_component.exited.connect(hide_outline)


func show_outline() -> void:
	mesh_instance.material_overlay = outline_material


func hide_outline() -> void:
	mesh_instance.material_overlay = null
