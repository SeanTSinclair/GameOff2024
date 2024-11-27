extends NPC

@export var path_nodes_act_1: Array[Node3D]


func _ready():
	super._ready()
	animation_player.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	animation_player.get_animation("Walk").loop_mode = Animation.LOOP_LINEAR


func _on_interacted() -> void:
	print("implement talk to mother here")
