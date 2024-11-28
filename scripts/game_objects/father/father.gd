class_name Father
extends NPC

signal interacted


func _ready():
	super._ready()
	animation_player.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	animation_player.get_animation("Walking").loop_mode = Animation.LOOP_LINEAR
	if DialogueManager != null:
		DialogueManager.register_npc(self)


func _on_interacted() -> void:
	if is_stopped:
		return
	emit_signal("interacted", self)


func freeze():
	is_stopped = true


func unfreeze():
	is_stopped = false
