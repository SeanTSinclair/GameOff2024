class_name SecretText
extends Node3D

@export var text_img: Texture2D
@export var text: String
@export var secret_text_id: String

@onready var text_plane = $MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var count = text_plane.get_surface_override_material_count()
	var mat = text_plane.get_active_material(0)
	mat.set_shader_parameter("tex", text_img)
