extends Node3D

const CREDITS = preload("res://scenes/ui/credits/credits.tscn")

@onready var player: Player = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	player.can_move = false
	animation_player.play("final_scene")
	SoundManager.stop("BGM")
	SoundManager.play_sfx("hoover_animation")
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
		SoundManager.play_sfx("flames")
	elif arg == "family_end":
		SoundManager.play_bgm("BGM")
		animation_player.play("die")
		SoundManager.play_sfx("dying")


func _animation_finished(animation_name: String):
	print("animation finished")
	if animation_name == "burn_baby_burn":
		SoundManager.stop("flames")
		SoundManager.stop("dying")
		SoundManager.play_bgm("BGM")
		get_tree().change_scene_to_packed(CREDITS)
	elif animation_name == "die":
		get_tree().change_scene_to_packed(CREDITS)
