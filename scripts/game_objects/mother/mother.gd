extends Node3D

@export var move_speed: float = 0.4
@export var path_nodes_act_1: Array[Node3D]

var is_stopped := false
var is_traveling_to_room := false
var next_travel_destination
var movement_delta: float

@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var animation_player: AnimationPlayer = $MotherOfificialAnimation/AnimationPlayer
@onready var navigation_agent: NavigationAgent3D = %NavigationAgent3D
@onready var armature: Node3D = $MotherOfificialAnimation/Armature


func _ready():
	animation_player.play("Idle")
	animation_player.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	animation_player.get_animation("Walk").loop_mode = Animation.LOOP_LINEAR
	interaction_component.interacted.connect(_on_interacted)
	navigation_agent.target_position = _get_random_path_node(path_nodes_act_1)
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))


func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)


func _physics_process(delta: float) -> void:
	if is_stopped:
		animation_player.play("Idle")
		return

	animation_player.play("Walk")

	# Do not query when the map has never synchronized and is empty.
	if NavigationServer3D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	if navigation_agent.is_navigation_finished():
		return

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
	print("implement talk to mother here")


func _get_random_path_node(nodes: Array[Node3D]) -> Vector3:
	var number_of_points = nodes.size() - 1
	var selected_node = randi_range(0, number_of_points)
	return nodes[selected_node].position


func _on_velocity_computed(safe_velocity: Vector3) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)
