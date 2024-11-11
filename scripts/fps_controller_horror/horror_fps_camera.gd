extends Node3D

var camera_sens = 0.005


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_parent().rotate_y(-event.relative.x * camera_sens)
		rotate_x(-event.relative.y * camera_sens)
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
