class_name Box
extends RigidBody3D

var blue_material = preload("res://scenes/game_objects/box/blue_material.tres")
var red_material = preload("res://scenes/game_objects/box/red_material.tres")

@onready var outline_component: OutlineComponent = $OutlineComponent
@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D


func _ready() -> void:
	interaction_component.interacted.connect(_on_interacted)
	interaction_component.entered.connect(_on_entered)
	interaction_component.exited.connect(_on_exited)


func _on_interacted() -> void:
	if mesh_instance.material_override == red_material:
		mesh_instance.material_override = blue_material
	else:
		mesh_instance.material_override = red_material


func _on_entered() -> void:
	outline_component.show_outline()


func _on_exited() -> void:
	outline_component.hide_outline()
