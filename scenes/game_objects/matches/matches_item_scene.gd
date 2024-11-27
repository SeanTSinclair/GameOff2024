extends Node3D

@export_range(0, 20) var sticks: int = 20


func use():
	sticks = sticks - 1
