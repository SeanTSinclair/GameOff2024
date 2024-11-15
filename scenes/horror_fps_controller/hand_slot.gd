extends Node3D


func _ready():
	Events.item_equipped.connect(_on_item_equipped)
	Events.item_unequipped.connect(_on_item_unequipped)


func _input(event):
	if event.is_action_pressed("shoot"):
		var children = get_children()
		for child in children:
			if child.has_method("use"):
				child.use()

func get_item_scene_instance(item: Item):
	if !item:
		return
	if !item.item_scene:
		return
	var item_scene = item.item_scene.instantiate()
	if item_scene != null:
		return item_scene


func _on_item_equipped(item: Item):
	var item_scene = get_item_scene_instance(item)
	if item_scene != null:
		add_child(item_scene)


func _on_item_unequipped(_item: Item):
	var children = get_children()
	for child in children:
		remove_child(child)
