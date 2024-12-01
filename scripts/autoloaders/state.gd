extends Node

# Blacklight state variables
var max_power = 100.0
var initial_power = 0.0
var power = 0.0
var initial_secrets_found = {}
var secret_texts_found = {}
var initial_keys_found = {}
var keys_found = {}
var start_time: int
var game_over: bool = false
var game_over_time: int = 0
var game_over_status: String = ""
var brightness_level: float = 0.15


func reset() -> void:
	power = initial_power
	secret_texts_found.clear()
	secret_texts_found = initial_secrets_found
	keys_found.clear()
	keys_found = initial_keys_found

	game_over = false
	game_over_time = -1
	game_over_status = ""

	start_time = Time.get_ticks_msec() / 1000


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
	Events.secret_message_found.emit(secret_text_id)


func is_secret_found(secret_text_id: String):
	return secret_texts_found.get(secret_text_id)


func add_key_found(key_id: String):
	keys_found[key_id] = true


func is_key_found(key_id: String):
	return keys_found.get(key_id) != null


func set_game_over(status: String) -> void:
	game_over = true
	game_over_time = get_current_time_in_sec()
	game_over_status = status


func get_current_time_in_sec() -> int:
	return (Time.get_ticks_msec() / 1000) - start_time
