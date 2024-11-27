extends Node3D

signal interacted

@export var move_speed: float = 0.15
@export var path_to_follow: PathFollow3D
@export var timeline = "testTimeline"

var is_stopped := false
var chatting = false
var player

@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var animation_player: AnimationPlayer = $FatherFullAnimation_2/AnimationPlayer


func _ready():
	animation_player.play("Idle")
	animation_player.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	animation_player.get_animation("Walking").loop_mode = Animation.LOOP_LINEAR
	interaction_component.interacted.connect(_on_interacted)
	if DialogueManager != null:
		DialogueManager.register_npc(self)


func set_player(player_node):
	player = player_node


func _physics_process(delta: float) -> void:
	if not path_to_follow:
		return
	if is_stopped:
		animation_player.play("Idle")
		return

	animation_player.play("Walking")
	path_to_follow.progress += move_speed * delta


func _on_interacted() -> void:
	if chatting:
		return
	emit_signal("interacted", self)


func freeze():
	is_stopped = true
	chatting = true


func unfreeze():
	is_stopped = false
	chatting = false
