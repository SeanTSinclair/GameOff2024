extends Node

var power = 100.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func get_power():
	return power


func remove_power(usage: float):
	power = max(power - usage, 0.0)


func add_power(energy: float):
	power += energy
