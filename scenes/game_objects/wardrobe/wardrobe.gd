extends Node3D

var opened: bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	Events.secret_book_interacted_with.connect(_on_secret_book_interacted_with)


func _on_secret_book_interacted_with() -> void:
	if opened:
		return
	opened = true
	animation_player.play("open")
	Events.journal.emit("I heard a strange sound, like something moved above me")
