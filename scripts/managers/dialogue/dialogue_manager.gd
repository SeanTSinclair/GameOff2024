extends Node

const FIND_FATHER = preload("res://resources/tasks/find_father.tres")
const FIND_MEDICINE_BOTTLE = preload("res://resources/tasks/find_medicine_bottle.tres")

var player
var npcs = []
var current_npc: Node = null


# Set the player reference
func set_player(player_ref):
	player = player_ref


# Set the NPC references
func set_npcs(npc_list):
	npcs = npc_list


func register_npc(npc):
	if not npcs.has(npc):
		npcs.append(npc)
		npc.connect("interacted", Callable(self, "start_dialogue"))


func unregister_npc(npc):
	if npcs.has(npc):
		npcs.erase(npc)


#test
func start_dialogue(npc_reference: Node = null):
	if player.is_on_floor() == false:
		return
	current_npc = npc_reference
	var timeline_name = current_npc.timeline
	if player == null:
		print("Error: Player not set!")
		return
	freeze_all()
	Dialogic.start(timeline_name)
	Dialogic.timeline_ended.connect(_on_dialogue_end)


func _on_dialogue_end():
	Dialogic.timeline_ended.disconnect(_on_dialogue_end)
	unfreeze_all()


func freeze_all():
	if player != null:
		player.freeze()
	if current_npc != null:
		current_npc.freeze()


func unfreeze_all():
	if player != null:
		player.unfreeze()
	if current_npc != null:
		current_npc.unfreeze()


func start_task(task_name: String):
	match task_name:
		"find_father":
			Events.task_received.emit(FIND_FATHER)
		"find_medicine_bottle":
			Events.task_received.emit(FIND_MEDICINE_BOTTLE)


func finish_task(task_name: String):
	match task_name:
		"find_father":
			Events.task_completed.emit(FIND_FATHER)
		"find_medicine_bottle":
			Events.task_received.emit(FIND_MEDICINE_BOTTLE)
