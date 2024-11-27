extends NPC

signal interacted


func _ready():
	super._ready()
	animation_player.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	animation_player.get_animation("Walk").loop_mode = Animation.LOOP_LINEAR


func _on_interacted() -> void:
	print("Implement this dude...")
	if is_stopped:
		return
	emit_signal("interacted", self)


func freeze():
	is_stopped = true


func unfreeze():
	is_stopped = false
