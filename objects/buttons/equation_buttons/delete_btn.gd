class_name DeleteBtn
extends BaseBtn

const DELETE_BTN_SCENE = preload("res://objects/buttons/equation_buttons/delete_btn.tscn")

static func new_btn(_value: String, _type: btn_type = btn_type.DELETE) -> DeleteBtn:
	var new_btn: DeleteBtn = DELETE_BTN_SCENE.instantiate()
	new_btn.set_value(_value)
	new_btn.set_type(_type)
	return new_btn
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_button_pressed() -> void:
	EventBus.delete_button_clicked.emit(false)
