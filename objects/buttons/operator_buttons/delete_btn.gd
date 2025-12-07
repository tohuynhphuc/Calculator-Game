class_name DeleteBtn
extends BaseBtn

const DELETE_BTN_SCENE = preload("res://objects/buttons/operator_buttons/delete_btn.tscn")


static func new_btn(_value: String, _type: ButtonType = ButtonType.DELETE) -> DeleteBtn:
	var new_button: DeleteBtn = DELETE_BTN_SCENE.instantiate()
	new_button.set_value(_value)
	new_button.set_type(_type)
	return new_button


func _on_button_pressed() -> void:
	EventBus.delete_button_clicked.emit(type == ButtonType.ALL_CLEAR)
	if type == ButtonType.ALL_CLEAR:
		GameManager.cursor_position = 0
	else:
		GameManager.move_cursor_left()
	print("Button pressed " + label.text)
	print("Cursor position " + str(GameManager.cursor_position))
	EventBus.equation_changed.emit()
