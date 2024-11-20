class_name Father
extends Node3D

@export var move_speed: float = 0.15
@export var path_to_follow: PathFollow3D

var is_stopped := false
var chatting = false
var player

@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var animation_player: AnimationPlayer = $FatherFullAnimation_2/AnimationPlayer


func _ready():
	animation_player.play("Idle")
	animation_player.get_animation("Idle").loop_mode = Animation.LOOP_LINEAR
	animation_player.get_animation("Walking").loop_mode = Animation.LOOP_LINEAR
	interaction_component.interacted.connect(_on_interacted)
	Dialogic.signal_event.connect(_on_dialogue_ended)


func set_player(player_node):
	player = player_node


func _physics_process(delta: float) -> void:
	if not path_to_follow:
		return
	if is_stopped:
		animation_player.play("Idle")
		return

	animation_player.play("Walking")
	path_to_follow.progress += move_speed * delta


func _on_interacted() -> void:
	if chatting:
		return
	run_dialogue("testTimeline")


func run_dialogue(dialouge_string):
	chatting = true
	is_stopped = true
	player.player_in_dialogue = true
	Dialogic.start(dialouge_string)


func _on_dialogue_ended(argument: String):
	if argument == "test_dialogue_ended":
		print("Test dialogue ended")
	chatting = false
	is_stopped = false
	player.player_in_dialogue = false
