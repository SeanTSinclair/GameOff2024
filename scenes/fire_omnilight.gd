extends OmniLight3D

@export var min_energy: float = 1  # Minimum brightness
@export var max_energy: float = 4  # Maximum brightness
@export var flicker_interval: float = 0.1  # Time between flickers

func _ready():
	var timer: Timer = $FlickerTimer  # Replace with your Timer node's name or path if different
	if timer:
		print("Timer found")
		# Connect the signal using Callable()
		timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
		timer.start(flicker_interval)
	else:
		print("Timer not found")

func _on_Timer_timeout():
	# Change the light's energy using the correct property
	light_energy = randf_range(min_energy, max_energy)
