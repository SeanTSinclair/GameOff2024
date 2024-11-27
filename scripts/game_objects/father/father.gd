extends Node3D

signal interacted

@export var move_speed: float = 0.15
@export var path_to_follow: PathFollow3D
@export var timeline = "father_timeline"

var is_stopped := false

@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var animation_player: AnimationPlayer = $FatherFullAnimation_2/AnimationPlayer


func _ready():
	animation_player.play("Idle")
	animation_player.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	animation_player.get_animation("Walking").loop_mode = Animation.LOOP_LINEAR
	interaction_component.interacted.connect(_on_interacted)
	if DialogueManager != null:
		DialogueManager.register_npc(self)


func _physics_process(delta: float) -> void:
	if not path_to_follow:
		return
	if is_stopped:
		animation_player.play("Idle")
		return

	animation_player.play("Walking")
	path_to_follow.progress += move_speed * delta


func _on_interacted() -> void:
	if is_stopped:
		return
	emit_signal("interacted", self)


func freeze():
	is_stopped = true


func unfreeze():
	is_stopped = false
