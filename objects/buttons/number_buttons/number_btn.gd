class_name NumberBtn
extends BaseBtn

@export var number : int

signal button_pressed

const NUMBER_BTN_SCENE = preload("res://objects/buttons/number_buttons/number_btn.tscn")

static func new_btn(num: int) -> NumberBtn:
	var new_btn: NumberBtn = NUMBER_BTN_SCENE.instantiate()
	new_btn.number = num
	return new_btn
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	EventBus.number_button_clicked.emit(number)
