class_name NumberBtn
extends BaseBtn

const NUMBER_BTN_SCENE = preload("res://objects/buttons/number_buttons/number_btn.tscn")

static func new_btn(_value: String, _type: btn_type = btn_type.NUMBER) -> NumberBtn:
	var new_btn: NumberBtn = NUMBER_BTN_SCENE.instantiate()
	new_btn.set_value(_value)
	new_btn.set_type(_type)
	return new_btn
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_button_pressed() -> void:
	EventBus.number_button_clicked.emit(value)
