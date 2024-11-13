extends Node3D  # or whatever type your character node is


func _ready():
	# Play the "Idle" animation as soon as the scene is ready
	$AnimationPlayer.play("Idle")
