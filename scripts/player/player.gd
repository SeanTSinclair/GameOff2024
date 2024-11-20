class_name Player
extends CharacterBody3D

@export var base_speed := 2
@export var sprint_speed := 2.5
@export var crouch_speed := 0.8
@export var jump_velocity := 2.8
@export var crouch_height := 1.0
@export var stand_height := 2.0

var speed = base_speed
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var footstep_timer = 0.0
var is_crouching = false

@onready var sound_footsteps = $SoundFootsteps
@onready var collision_shape = $CollisionShape3D
@onready var head = $Head
@onready var up_ray = $UpRay


func _physics_process(delta: float) -> void:
	calculate_velocity(delta)  # Calculates velocity and direction to be used in move_and_slide
	footsteps()
	handle_crouch()
	move_and_slide()


func calculate_velocity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_crouching:
		velocity.y += jump_velocity

	speed = base_speed
	if Input.is_action_pressed("sprint") and not is_crouching:
		speed = sprint_speed
	elif is_crouching:
		speed = crouch_speed

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, base_speed)
		velocity.z = move_toward(velocity.z, 0, base_speed)


func footsteps() -> void:
	sound_footsteps.stream_paused = true

	if is_on_floor():
		if abs(velocity.x) > 1 or abs(velocity.z) > 1:
			sound_footsteps.stream_paused = false


func handle_crouch() -> void:
	if Input.is_action_pressed("crouch"):
		if not is_crouching:
			is_crouching = true
			adjust_crouch(true)
	elif is_crouching and not up_ray.is_colliding():
		is_crouching = false
		adjust_crouch(false)


func adjust_crouch(to_crouch: bool) -> void:
	if to_crouch:
		collision_shape.shape.height = crouch_height
		head.position.y -= (stand_height - crouch_height) / 2
	else:
		collision_shape.shape.height = stand_height
		head.position.y += (stand_height - crouch_height) / 2
