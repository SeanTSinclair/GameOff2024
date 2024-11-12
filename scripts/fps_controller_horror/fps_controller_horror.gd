extends CharacterBody3D

signal footstep

const BASE_SPEED = 1.15
const SPRINT_SPEED = 1.5
const JUMP_VELOCITY = 2.0
const WALK_FOOTSTEP_INTERVAL = 0.87
const SPRINT_FOOSTEP_INTERVAL = 0.83

var speed = BASE_SPEED
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var footstep_timer = 0.0


func _physics_process(delta: float) -> void:
	calculate_velocity(delta)  # Calculates velocity and direction to be used in move_and_slide
	footsteps(delta)

	move_and_slide()


func calculate_velocity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY

	speed = BASE_SPEED
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, BASE_SPEED)
		velocity.z = move_toward(velocity.z, 0, BASE_SPEED)


func footsteps(delta: float) -> void:
	if velocity.x != 0 or velocity.z != 0:
		var footstep_interval = WALK_FOOTSTEP_INTERVAL
		if speed == SPRINT_SPEED:
			footstep_interval = SPRINT_FOOSTEP_INTERVAL

		footstep_timer += delta

		if footstep_timer >= footstep_interval:
			print("Footstep")
			footstep.emit()
			footstep_timer = 0.0
	else:
		footstep_timer = 0.0
