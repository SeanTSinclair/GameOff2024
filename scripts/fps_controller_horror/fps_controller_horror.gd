extends CharacterBody3D

const BASE_SPEED = 1.15
const SPRINT_SPEED = 1.5
const JUMP_VELOCITY = 2.0
const WALK_FOOTSTEP_INTERVAL = 0.87
const SPRINT_FOOSTEP_INTERVAL = 0.83

var speed = BASE_SPEED
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var footstep_timer = 0.0

@onready var sound_footsteps = $SoundFootsteps
@onready var equip_slot = $HandItemSlot


func _ready():
	Events.item_equipped.connect(_on_item_equipped)
	Events.item_unequipped.connect(_on_item_unequipped)


func _physics_process(delta: float) -> void:
	calculate_velocity(delta)  # Calculates velocity and direction to be used in move_and_slide
	footsteps()

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


func footsteps() -> void:
	sound_footsteps.stream_paused = true

	if is_on_floor():
		if abs(velocity.x) > 1 or abs(velocity.z) > 1:
			sound_footsteps.stream_paused = false


func _on_item_equipped(item: Item):
	print("Adding : ", item.name)
	equip_slot.add_child(item.item_scene.instantiate())


func _on_item_unequipped(item: Item):
	print("Removing : ", item.name)
	equip_slot.remove_child(item.item_scene.instantiate())
