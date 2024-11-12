class_name FPSCamera
extends Node3D

@export_range(0.0015, 0.005) var camera_sens = 0.0025
@export_range(0.0, 1.0) var bob_strength = 0.0036  # Adjusts head bobbing strength
var bob_speed = 5.0  # Speed of the bobbing effect
var bob_timer = 0.0  # Tracks time for sine wave movement
var base_position: Vector3  # Stores the initial position of the camera


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	base_position = position  # Store the starting position


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_parent().rotate_y(-event.relative.x * camera_sens)
		rotate_x(-event.relative.y * camera_sens)
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))


func _process(delta: float) -> void:
	# Increment timer based on delta to create a continuous wave
	bob_timer += delta * bob_speed

	# Calculate bobbing offset using a sine wave
	var bob_offset = sin(bob_timer) * bob_strength

	# Apply bobbing effect to the y position
	position.y = base_position.y + bob_offset
	position.x = base_position.x + bob_offset
