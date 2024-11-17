extends Node3D

@export_range(5, 90) var minor_flicker_threshold_percentage: float = 90
@export_range(1, 50) var major_flicker_threshold_percentage: float = 25
@export var flicker_speed: float = 0.08  # Time between flickers
@export var minor_flicker_intensity: float = 0.13
@export var major_flicker_intensity: float = 0.38

var active = false
var flicker_timer: float = 0.0

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

		# Flickering logic
		flicker_timer += delta
		if flicker_timer >= flicker_speed:
			flicker_timer = 0.0
			apply_flicker(power)


func use():
	active = !active
	print("Active : ", active)
	if active:
		light.spot_range = 10
	else:
		light.spot_range = 0


func apply_flicker(power):
	# Calculate thresholds based on the power percentage
	var power_percentage = power / State.get_max_power() * 100
	if power_percentage <= major_flicker_threshold_percentage:
		# Major flicker
		light.light_energy += randf_range(-major_flicker_intensity, major_flicker_intensity)
	elif power_percentage <= minor_flicker_threshold_percentage:
		# Minor flicker
		light.light_energy += randf_range(-minor_flicker_intensity, minor_flicker_intensity)

	# Clamp energy to prevent unrealistic values
	light.light_energy = clamp(light.light_energy, 0.1, 1.5)
