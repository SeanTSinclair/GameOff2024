extends Node3D

var open = false

@onready
var interaction_component: InteractionComponent = $mansion_standard_door/InteractionComponent
@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready():
	interaction_component.interacted.connect(_on_interacted)


func _on_interacted() -> void:
	print("Opening")
	if open:
		anim_player.play("Open")
	else:
		anim_player.play_backwards("Open")
	open = !open
