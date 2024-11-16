class_name Father
extends Node3D

@onready var animation_player: AnimationPlayer = $officialfather/AnimationPlayer


func _ready():
	animation_player.play("Idle")
	animation_player.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
