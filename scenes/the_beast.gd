# This is just for fun to have a crawling father on the wall
class_name TheBeast
extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	animation_player.play("Sitting Idle")
	animation_player.get_animation("Sitting Idle").loop_mode = Animation.LOOP_LINEAR
