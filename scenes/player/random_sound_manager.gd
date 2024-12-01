extends Node

@export var min_duration_between_sounds: float = 20
@export var max_duration_between_sounds: float = 80

var sounds_array = [
	"RAND1",
	"RAND2",
	"RAND3",
	"RAND4",
	"RAND5",
	"RAND6",
	"RAND7",
	"RAND8",
	"RAND9",
	"RAND10",
	"RAND11"
]

@onready var timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_play_random_one_shot_from_random_sounds)
	timer.start()


func _play_random_one_shot_from_random_sounds():
	timer.start(randf_range(min_duration_between_sounds, max_duration_between_sounds))
	var selected_track = sounds_array[randi_range(0, sounds_array.size() - 1)]
	SoundManager.play_sfx(selected_track, 0, -26, randf_range(0.65, 0.85))
