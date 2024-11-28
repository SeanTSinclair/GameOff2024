extends Node3D

@export_range(5, 90) var minor_flicker_threshold_percentage: float = 90
@export_range(1, 50) var major_flicker_threshold_percentage: float = 25
@export var flicker_speed: float = 0.08  # Time between flickers
@export var minor_flicker_intensity: float = 0.13
@export var major_flicker_intensity: float = 0.38

var active = false
var flicker_timer: float = 0.0

@onready var light = $flashlight/Blacklight
@onready var ray = $flashlight/RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready():
	ray.enabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ray.enabled = active
	if active:
		var power = State.get_power()
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

		if ray.is_colliding():
			var collision: CollisionObject3D = ray.get_collider()
			var secret = collision.get_parent_node_3d().get_parent_node_3d()
			if secret is SecretText:
				var secret_id = secret.secret_text_id
				var secret_found = State.is_secret_found(secret_id)
				if secret_found == null:
					State.add_secret_found(secret_id)
					Events.journal.emit(secret.text)


func use():
	active = !active
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
