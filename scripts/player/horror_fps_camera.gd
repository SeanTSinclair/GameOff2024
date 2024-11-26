class_name FPSCamera
extends Node3D

@export_range(0.0015, 0.005) var camera_sens = 0.0025
@export_range(0.0, 1.0) var bob_strength = 0.0036  # Adjusts head bobbing strength
var bob_speed = 5.0  # Speed of the bobbing effect
var bob_timer = 0.0  # Tracks time for sine wave movement
var base_position: Vector3  # Stores the initial position of the camera

var defined_viewport_size: Vector2
var actual_window_size: Vector2
var current_scale: float


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	base_position = position  # Store the starting position

	defined_viewport_size = get_viewport().get_visible_rect().size
	_update_actual_window_size()
	get_tree().root.size_changed.connect(_update_actual_window_size)
	Events.game_unpaused.connect(_update_actual_window_size)


func _update_actual_window_size() -> void:
	actual_window_size = get_viewport().size
	var x_scale = actual_window_size.x / defined_viewport_size.x
	var y_scale = actual_window_size.y / defined_viewport_size.y
	current_scale = (x_scale if x_scale < y_scale else y_scale) / 2


func _process(delta: float) -> void:
	# Increment timer based on delta to create a continuous wave
	bob_timer += delta * bob_speed

	# Calculate bobbing offset using a sine wave
	var bob_offset = sin(bob_timer) * bob_strength

	# Apply bobbing effect to the y position
	position.y = base_position.y + bob_offset
	position.x = base_position.x + bob_offset
