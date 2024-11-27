extends Node3D

signal interacted

@export var timeline = "grandmother_timeline"

var is_stopped = false

@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var animation_player: AnimationPlayer = $GrannOfficialAnimation/AnimationPlayer


func _ready():
	animation_player.play("Sitting_Idle")
	animation_player.get_animation("Sitting_Idle").loop_mode = Animation.LOOP_LINEAR
	interaction_component.interacted.connect(_on_interacted)
	if DialogueManager != null:
		DialogueManager.register_npc(self)


func _on_interacted() -> void:
	if is_stopped:
		return
	emit_signal("interacted", self)


func freeze():
	is_stopped = true


func unfreeze():
	is_stopped = false
