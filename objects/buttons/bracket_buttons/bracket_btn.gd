class_name BracketBtn
extends BaseBtn

const BRACKET_BTN_SCENE = preload("res://objects/buttons/bracket_buttons/bracket_btn.tscn")

var is_left: bool
var brackets_pair = {
	"(": ")",
	"[": "]",
	"{": "}",
}


static func new_btn(_value: String, _type: ButtonType = ButtonType.BRACKET) -> BracketBtn:
	var new_button: BracketBtn = BRACKET_BTN_SCENE.instantiate()
	new_button.set_value(_value)
	new_button.set_type(_type)
	return new_button


func set_orientation(_is_left: bool) -> void:
	is_left = _is_left


func _on_button_pressed() -> void:
	# TODO: Brackets currently calling operator_button_clicked -> add bracket_button_clicked
	EventBus.operator_button_clicked.emit(value)
	GameManager.move_cursor_right()
	print("Button pressed " + label.text)
	print("Cursor position " + str(GameManager.cursor_position))
	EventBus.equation_changed.emit()
