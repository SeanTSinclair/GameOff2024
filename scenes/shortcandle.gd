# This is just for fun to have a crawling father on the wall
class_name shortcandle
extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	animation_player.play("KeyAction_002")
	animation_player.get_animation("KeyAction_002").loop_mode = Animation.LOOP_LINEAR
