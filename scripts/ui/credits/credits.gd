class_name CreditsMenu
extends CanvasLayer

const ROLE_COLOR: String = "#aaaaaa"
const TIME_COLOR: String = "#ffaaaa"

@export var contributors: Array[Contributor]

@onready var back_button: Button = %BackButton
@onready var label: RichTextLabel = %CreditsRichTextLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)

	label.clear()
	label.text = ""

	label.append_text("[center]")

	if State.game_over:
		label.push_font_size(25)
		label.append_text("Game Over\n\n")
		label.pop()
		label.append_text(State.game_over_status + "\n\n")
		var time = _format_time(State.game_over_time)
		label.append_text(
			"You finished the game in: [color=" + TIME_COLOR + "]" + time + "[/color]\n\n\n"
		)

	label.push_font_size(25)
	label.append_text("Credits\n\n")
	label.pop()

	for contributor in contributors:
		add_contributor(contributor)

	if State.game_over:
		label.push_font_size(30)
		label.append_text("\n\n\n\n\n- THE END -")
		label.pop()
		animation_player.play("game_over")
	else:
		animation_player.play("scroll")


func add_contributor(contributor: Contributor) -> void:
	label.append_text(
		(
			"[color="
			+ ROLE_COLOR
			+ "]"
			+ contributor.role_name
			+ "[/color]\n"
			+ contributor.display_name
			+ "\n\n"
		)
	)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")


func _format_time(time: int) -> String:
	var minutes: int = time / 60
	var seconds: int = time % 60
	return "%02d:%02d" % [minutes, seconds]
