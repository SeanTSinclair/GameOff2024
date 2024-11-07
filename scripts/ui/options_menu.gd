class_name OptionsMenu
extends CanvasLayer

signal back_pressed

@onready var back_button: Button = %BackButton
@onready var display_button: Button = %DisplayButton
@onready var sfx_slider: HSlider = %SfxSlider
@onready var music_slider: HSlider = %MusicSlider


func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)
	display_button.pressed.connect(_on_display_button_pressed)
	sfx_slider.value_changed.connect(_on_audio_slide_changed.bind("sfx"))
	music_slider.value_changed.connect(_on_audio_slide_changed.bind("music"))
	_update_display()


func _update_display() -> void:
	display_button.text = "Windowed"
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		display_button.text = "Fullscreen"
	sfx_slider.value = _get_bus_volume_precent("sfx")
	music_slider.value = _get_bus_volume_precent("music")


func _on_display_button_pressed() -> void:
	var mode := DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	_update_display()


func _on_back_button_pressed() -> void:
	back_pressed.emit()


func _get_bus_volume_precent(bus_name: String) -> float:
	var bus_index := AudioServer.get_bus_index(bus_name)
	var volume_db := AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)


func _set_bus_volume_precent(bus_name: String, percent: float) -> void:
	var bus_index := AudioServer.get_bus_index(bus_name)
	var volume_db := linear_to_db(percent)
	AudioServer.set_bus_volume_db(bus_index, volume_db)


func _on_audio_slide_changed(value: float, bus_name: String) -> void:
	_set_bus_volume_precent(bus_name, value)
