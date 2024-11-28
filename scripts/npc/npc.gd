class_name NPC
extends Node3D

@export_category("Movement")
@export var move_speed: float = 0.4
@export var should_move: bool = false

@export_category("Animations")
@export var idle_animation_string: String = "Idle"
@export var walk_animation_string: String = "Walk"
# @export var sit_animation_string = "Sitting_Idle" #Granny idle anim

@export_category("Dialogue")
@export var timeline: String

var navigation_manager: NavigationManager
var player: Player
var movement_delta: float
var is_stopped: bool = false

@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var animation_player: AnimationPlayer = $Body/AnimationPlayer
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D


func _ready() -> void:
	# Setup Nav and Player refs
	if !navigation_manager and should_move:
		navigation_manager = get_tree().get_first_node_in_group("navigation_manager")
	player = get_tree().get_first_node_in_group("player")

	if should_move:
		assert(navigation_manager, "NavigationManager not found from node " + name)
	assert(player, "Player reference not found from node " + name)

	# Interaction setup
	interaction_component.interacted.connect(_on_interacted)
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

	if should_move:
		call_deferred("_navigate_to_random_location")


func _navigate_to_random_location():
	navigation_agent.target_position = navigation_manager.get_random_location().position


func _physics_process(delta: float) -> void:
	if is_stopped:
		animation_player.play(idle_animation_string)
		return

	animation_player.play(walk_animation_string)

	# Do not query when the map has never synchronized and is empty.
	if should_move:
		if NavigationServer3D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
			return
		if navigation_agent.is_navigation_finished():
			animation_player.play(idle_animation_string)
			return

		_handle_movement(delta)


func _handle_movement(delta: float) -> void:
	movement_delta = move_speed * delta
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_delta
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

	if global_position.distance_to(next_path_position) > 0.01:
		var direction = global_position.direction_to(next_path_position)
		rotation.y = atan2(direction.x, direction.z)


func _on_interacted() -> void:
	print("NOT YET IMPLEMENTED.")


func _on_velocity_computed(safe_velocity: Vector3) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)


func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
