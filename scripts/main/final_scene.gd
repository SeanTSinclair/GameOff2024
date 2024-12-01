extends Node3D

@onready var player: Player = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	player.can_move = false
	animation_player.play("final_scene")
	Dialogic.signal_event.connect(_burn_scene_run)


func queue_hover() -> void:
	animation_player.play("hover")
	DialogueManager.start_dialogue_no_npc("being")


func show_being_moved_by_force_text() -> void:
	Events.feedback.emit("What? I'm being moved against my will!")


func _burn_scene_run(arg) -> void:
	if arg == "burn_baby_burn":
		animation_player.play("burn_baby_burn")
