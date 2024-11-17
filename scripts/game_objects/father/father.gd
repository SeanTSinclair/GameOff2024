class_name Father
extends Node3D

@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var animation_player: AnimationPlayer = $FatherFullAnimation_2/AnimationPlayer


func _ready():
	animation_player.play("Idle")
	animation_player.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	interaction_component.interacted.connect(_on_interacted)


func _on_interacted() -> void:
	print("implement talk to father here")
