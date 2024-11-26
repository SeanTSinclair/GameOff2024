extends Node3D

@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var animation_player: AnimationPlayer = $GrannOfficialAnimation/AnimationPlayer


func _ready():
	animation_player.play("Sitting_Idle")
	animation_player.get_animation("Sitting_Idle").loop_mode = Animation.LOOP_LINEAR
	interaction_component.interacted.connect(_on_interacted)


func _on_interacted() -> void:
	print("implement talk to grandmother here")
