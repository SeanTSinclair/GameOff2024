# This is just for fun to have a crawling father on the wall
class_name CrawlingFather
extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	animation_player.play("Crawl")
	animation_player.get_animation("Crawl").loop_mode = Animation.LOOP_LINEAR
