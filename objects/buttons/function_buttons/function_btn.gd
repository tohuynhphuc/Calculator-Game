class_name FunctionBtn
extends BaseBtn

const FUNCTION_BTN_SCENE = preload("res://objects/buttons/function_buttons/function_btn.tscn")


static func new_btn(_value: String, _type: ButtonType = ButtonType.FUNCTION) -> FunctionBtn:
	var new_button: FunctionBtn = FUNCTION_BTN_SCENE.instantiate()
	new_button.set_value(_value)
	new_button.set_type(_type)
	return new_button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_button_pressed() -> void:
	EventBus.function_button_clicked.emit(value)
	GameManager.move_cursor_right()
	print("Button pressed " + label.text)
	print("Cursor position " + str(GameManager.cursor_position))
	EventBus.equation_changed.emit()
