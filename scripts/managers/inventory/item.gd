class_name Item
extends Resource

@export var id: String
@export var name: String
@export var inventory_texture: Texture2D
@export var item_scene: PackedScene
@export_multiline var description: String = ""
@export var equippable: bool
@export var hint_message: String

@export var pickup_completes_task: Task
@export var pickup_triggers_task: Task
