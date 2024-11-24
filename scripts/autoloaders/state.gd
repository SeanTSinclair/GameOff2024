extends Node

# Blacklight state variables
var max_power = 100.0
var initial_power = 0.0
var power = 0.0


func reset() -> void:
	power = initial_power


func get_power():
	return power


func get_max_power():
	return max_power


func remove_power(usage: float):
	power = max(power - usage, 0.0)


func add_power(energy: float):
	power = min(power + energy, max_power)
