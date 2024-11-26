class_name NPC
extends Node3D

@export_category("Movement")
@export var move_speed: float = 0.4
@export var should_move: bool = false

@export_category("Animations")
@export var idle_animation_string = "Idle"
@export var walk_animation_string = "Walk"
@export var sit_animation_string = "Sitting_Idle"

var navigation_manager: NavigationManager
var player: Player

@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var animation_player: AnimationPlayer = $Body/AnimationPlayer
@onready var navigation_agent: NavigationAgent3D = %NavigationAgent3D


func _ready() -> void:
	# Setup Nav and Player refs
	if !navigation_manager:
		navigation_manager = get_tree().get_first_node_in_group("navigation_manager")
	player = get_tree().get_first_node_in_group("player")

	assert(navigation_manager, "NavigationManager not found from node " + name)
	assert(player, "Player reference not found from node " + name)

	# Interaction setup
	interaction_component.interacted.connect(_on_interacted)


func _on_interacted() -> void:
	print("NOT YET IMPLEMENTED.")
