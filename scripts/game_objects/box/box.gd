class_name Box
extends RigidBody3D

var blue_material = preload("res://scenes/game_objects/box/blue_material.tres")
var red_material = preload("res://scenes/game_objects/box/red_material.tres")

@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D


func _ready() -> void:
	interaction_component.interacted.connect(_on_interacted)


func _on_interacted() -> void:
	if mesh_instance.material_override == red_material:
		mesh_instance.material_override = blue_material
	else:
		mesh_instance.material_override = red_material
