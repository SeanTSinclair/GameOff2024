extends Node3D

@export var key_id: String = ""

var open = false

@onready
var interaction_component: InteractionComponent = $mansion_standard_door/InteractionComponent
@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready():
	interaction_component.interacted.connect(_on_interacted)
	anim_player.speed_scale = 0.25


func _on_interacted() -> void:
	var origin_open = open
	if key_id != "":
		if State.is_key_found(key_id):
			print("Hey")
			open = !open
	else:
		open = !open

	if origin_open != open:
		if open:
			anim_player.play("Open")
		else:
			anim_player.play_backwards("Open")
