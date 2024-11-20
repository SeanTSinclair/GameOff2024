extends CharacterBody3D

@export var base_speed := 1.15
@export var sprint_speed := 1.5
@export var jump_velocity := 2.0

var speed = base_speed
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var footstep_timer = 0.0
var player_in_dialogue = false

@onready var sound_footsteps = $SoundFootsteps


func _physics_process(delta: float) -> void:
	calculate_velocity(delta)  # Calculates velocity and direction to be used in move_and_slide
	footsteps()

	move_and_slide()


func calculate_velocity(delta: float) -> void:
	if player_in_dialogue:
		velocity.x = 0
		velocity.z = 0
		return

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_velocity

	speed = base_speed
	if Input.is_action_pressed("sprint"):
		speed = sprint_speed

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
