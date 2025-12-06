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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_button_pressed() -> void:
	EventBus.equation_button_clicked.emit(value)
	GameManager.move_cursor_right()
	print("Button pressed " + label.text)
	print("Cursor position " + str(GameManager.cursor_position))
	EventBus.equation_changed.emit()
