extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation = "menu-loop"  # Set the animation to "menu-loop"
	play()  # Start playing the animation
