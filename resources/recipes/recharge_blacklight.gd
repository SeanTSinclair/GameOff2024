class_name RechargeBlacklight
extends Recipe

@export var completes_task: Task


func combine(inventory_manager: InventoryManager) -> bool:
	if !inventory_has_required_items(inventory_manager):
		return false

	inventory_manager.take(item2)

	State.add_power(100.0)

	if completes_task:
		Events.task_completed.emit(completes_task)

	return true
