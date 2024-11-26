extends Node

# Blacklight state variables
var max_power = 100.0
var initial_power = 0.0
var power = 0.0
var initial_secrets_found = {}
var secret_texts_found = {}

func reset() -> void:
	power = initial_power
	secret_texts_found = initial_secrets_found


func get_power():
	return power


func get_max_power():
	return max_power


func remove_power(usage: float):
	power = max(power - usage, 0.0)


func add_power(energy: float):
	power = min(power + energy, max_power)

func add_secret_found(secret_text_id: String):
	secret_texts_found[secret_text_id] = true

func is_secret_found(secret_text_id: String):
	return secret_texts_found.get(secret_text_id)
