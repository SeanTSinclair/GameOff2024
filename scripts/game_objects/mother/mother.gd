class_name Mother
extends Node3D

@export var move_speed: float = 0.4
@export var path_to_follow: PathFollow3D

var is_stopped := false

@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var animation_player: AnimationPlayer = $MotherOfificialAnimation/AnimationPlayer


func _ready():
	animation_player.play("Idle")
	animation_player.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	animation_player.get_animation("Walk").loop_mode = Animation.LOOP_LINEAR
	interaction_component.interacted.connect(_on_interacted)


func _physics_process(delta: float) -> void:
	if not path_to_follow:
		return
	if is_stopped:
		animation_player.play("Idle")
		return

	animation_player.play("Walk")
	path_to_follow.progress += move_speed * delta


func _on_interacted() -> void:
	print("implement talk to mother here")
