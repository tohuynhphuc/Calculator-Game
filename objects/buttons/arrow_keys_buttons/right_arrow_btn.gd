class_name RightArrowBtn
extends BaseBtn


const RIGHT_ARROW_BTN_SCENE = preload("res://objects/buttons/arrow_keys_buttons/right_arrow_btn.tscn")

static func new_btn(_value: String = "->", _type: btn_type = btn_type.ARROW_RIGHT) -> RightArrowBtn:
	var new_btn: RightArrowBtn = RIGHT_ARROW_BTN_SCENE.instantiate()
	new_btn.set_value(_value)
	new_btn.set_type(_type)
	return new_btn
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_button_pressed() -> void:
	EventBus.arrow_button_clicked.emit(type == btn_type.ARROW_RIGHT)
	GameManager.move_cursor_right()
	print("Button pressed " + label.text)
	print("Cursor position " + str(GameManager.cursor_position))
	EventBus.equation_changed.emit()
