class_name InteractionRay
extends RayCast3D

var last_collider: InteractionComponent

@onready var label: Label = $Label


func _ready() -> void:
	label.text = ""


func _physics_process(_delta: float) -> void:
	var current_collider := _get_current_collider()

	if current_collider != last_collider:
		if last_collider:
			last_collider.exit()
		if current_collider:
			current_collider.enter()

	if current_collider:
		label.text = current_collider.get_prompt()
	else:
		label.text = ""

	if current_collider and Input.is_action_just_pressed(current_collider.prompt_action):
		current_collider.interact()

	last_collider = current_collider


func _get_current_collider() -> InteractionComponent:
	if not is_colliding():
		return null

	var collider = get_collider()
	if not collider is InteractionComponent:
		return null

	return collider
