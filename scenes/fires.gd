extends Node

@export var burn_rate = 1

var fire_growing: bool = false

@onready var group_1: Node3D = $Group1
@onready var group_2: Node3D = $Group2
@onready var group_3: Node3D = $Group3
@onready var group_4: Node3D = $Group4
@onready var group_5: Node3D = $Group5
@onready var group_6: Node3D = $Group6

@onready var player_fire: AnimatedSprite3D = $Group6/Fire
@onready var being_fire: AnimatedSprite3D = $Group6/Fire2


func show_group_1():
	group_1.visible = true


func show_group_2():
	group_2.visible = true


func show_group_3():
	group_3.visible = true


func show_group_4():
	group_4.visible = true


func show_group_5():
	group_5.visible = true


func show_group_6():
	group_6.visible = true


func _physics_process(_delta: float) -> void:
	if fire_growing:
		scale_fires()


func scale_fires():
	var tween = get_tree().create_tween()
