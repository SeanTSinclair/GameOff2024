extends Node3D

@onready var player: Player = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	player.can_move = false
	animation_player.play("final_scene")


func queue_hover() -> void:
	animation_player.play("hover")
	DialogueManager.start_dialogue_no_npc("being")


func show_being_moved_by_force_text() -> void:
	Events.feedback.emit("What? I'm being moved against my will!")
