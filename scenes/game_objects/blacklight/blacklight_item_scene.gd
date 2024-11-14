extends Node3D

var active = false
@onready var light = $fleshlight/Blacklight


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		var power = State.get_power()
		print("Power left : ", power)
		if power <= 0:
			active = false
			light.spot_range = 0
			return
		State.remove_power(1.0 * delta)


func use():
	active = !active
	print("Active : ", active)
	if active:
		light.spot_range = 10
	else:
		light.spot_range = 0
