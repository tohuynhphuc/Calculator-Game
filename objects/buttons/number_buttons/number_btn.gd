class_name NumberBtn
extends BaseBtn

const NUMBER_BTN_SCENE = preload("res://objects/buttons/number_buttons/number_btn.tscn")

var number_obj: Number

@onready var button = $Button


static func new_btn(num: Number) -> NumberBtn:
	var new_button: NumberBtn = NUMBER_BTN_SCENE.instantiate()
	new_button.set_value(str(num.value))
	new_button.set_type(ButtonType.NUMBER)
	new_button.number_obj = num
	return new_button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_button_pressed() -> void:
	EventBus.number_button_clicked.emit(number_obj)
	button.disabled = true
	GameManager.move_cursor_right()
	print("Button pressed " + label.text)
	print("Cursor position " + str(GameManager.cursor_position))
	EventBus.equation_changed.emit()
