extends Node

@warning_ignore("unused_signal")
signal picked_up_item(item: Item)

@warning_ignore("unused_signal")
signal item_equipped(item: Item)

@warning_ignore("unused_signal")
signal item_unequipped(item: Item)

@warning_ignore("unused_signal")
signal equipped_item_activation

@warning_ignore("unused_signal")
signal journal(message: String)

@warning_ignore("unused_signal")
signal feedback(message: String)

@warning_ignore("unused_signal")
signal feedback_given(time: int, message: String)

@warning_ignore("unused_signal")
signal task_received(task: Task)

@warning_ignore("unused_signal")
signal task_completed(task: Task)

@warning_ignore("unused_signal")
signal game_unpaused

@warning_ignore("unused_signal")
signal secret_message_found(id: String)

@warning_ignore("unused_signal")
signal secret_book_interacted_with

@warning_ignore("unused_signal")
signal brightness_level_changed(value: float)
