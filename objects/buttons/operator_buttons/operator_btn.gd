class_name OperatorBtn
extends BaseBtn

const OPERATOR_BTN_SCENE = preload("res://objects/buttons/operator_buttons/operator_btn.tscn")

var operator_obj: Operator


static func new_btn(op: Operator) -> OperatorBtn:
	var new_button: OperatorBtn = OPERATOR_BTN_SCENE.instantiate()
	new_button.set_value(op.value)
	new_button.set_type(ButtonType.OPERATOR)
	new_button.operator_obj = op
	return new_button


func _on_button_pressed() -> void:
	EventBus.operator_button_clicked.emit(operator_obj)
	GameManager.move_cursor_right()
	print("Button pressed " + label.text)
	print("Cursor position " + str(GameManager.cursor_position))
	EventBus.equation_changed.emit()
