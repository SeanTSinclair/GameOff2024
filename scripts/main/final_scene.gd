extends Node3D

const CREDITS = preload("res://scenes/ui/credits/credits.tscn")

@onready var player: Player = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	player.can_move = false
	animation_player.play("final_scene")
	Dialogic.signal_event.connect(_final_scene_run)
	animation_player.animation_finished.connect(_animation_finished)


func queue_hover() -> void:
	animation_player.play("hover")
	DialogueManager.start_dialogue_no_npc("being")


func show_being_moved_by_force_text() -> void:
	Events.feedback.emit("What? I'm being moved against my will!")


func _final_scene_run(arg) -> void:
	if arg == "burn_baby_burn":
		animation_player.play("burn_baby_burn")
	elif arg == "family_end":
		get_tree().change_scene_to_packed(CREDITS)


func _animation_finished(animation_name: String):
	print("animation finished")
	if animation_name == "burn_baby_burn":
		get_tree().change_scene_to_packed(CREDITS)
	#elif animation_name == "family_end":
	#get_tree().change_scene_to_packed(CREDITS)
