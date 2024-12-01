extends Node3D

@onready var player: Player = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	player.can_move = false
	animation_player.play("final_scene")


func queue_hover() -> void:
	animation_player.play("hover")
	DialogueManager.start_dialogue_no_npc("being")
