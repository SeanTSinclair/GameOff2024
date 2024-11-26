class_name NavigationManager
extends Node

@export_group("Locations")
@export var mc_bedroom: Node3D
@export var grandma_bedroom: Node3D
@export var parents_bedroom: Node3D
@export var guest_bedroom: Node3D
@export var living_room: Node3D
@export var kitchen: Node3D
@export var main_entrance: Node3D
@export var hallway_stairs_first_floor: Node3D
@export var hallway_stairs_middle_floor: Node3D
@export var hallway_stairs_second_floor: Node3D
@export var hallway_stairs_basement: Node3D
@export var dining_room: Node3D
@export var basement_first_room: Node3D
@export var basement_second_room: Node3D
@export var broom_closet: Node3D
@export var study: Node3D
@export var bathroom: Node3D
@export var lavatory: Node3D
@export var playroom: Node3D
@export var portrait_room: Node3D
@export var outlook_corner_1: Node3D
@export var outlook_corner_2: Node3D
@export var outlook_corner_3: Node3D
@export var outlook_corner_4: Node3D

var valid_rooms = []


func _ready() -> void:
	var rooms = [
		mc_bedroom,
		grandma_bedroom,
		parents_bedroom,
		guest_bedroom,
		living_room,
		kitchen,
		main_entrance,
		hallway_stairs_first_floor,
		hallway_stairs_middle_floor,
		hallway_stairs_second_floor,
		hallway_stairs_basement,
		dining_room,
		basement_first_room,
		basement_second_room,
		broom_closet,
		study,
		bathroom,
		lavatory,
		playroom,
		portrait_room
	]

	for room in rooms:
		if room != null:
			valid_rooms.append(room)


func get_random_location() -> Node3D:
	return valid_rooms[randi() % valid_rooms.size()]
