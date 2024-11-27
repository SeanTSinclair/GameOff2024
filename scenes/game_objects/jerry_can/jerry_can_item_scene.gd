extends Node3D

@export_range(0, 100) var fuel: float = 100

var active = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		fuel = fuel - (1.0 * delta)
		if fuel <= 0.0:
			active = false
			return


func use():
	active = !active
