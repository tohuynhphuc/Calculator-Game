class_name BaseBtn
extends Control

enum ButtonType {
	BASE,
	NUMBER,
	EQUATION,
	BRACKET,
	FUNCTION,
	DELETE,
	ALL_CLEAR,
	ARROW_LEFT,
	ARROW_RIGHT,
}

const BTN_SCENE = preload("res://objects/buttons/base_btn.tscn")

@export var label: Label

var type: ButtonType
var value: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if label.text != value:
		label.text = value


#static func new_btn(_value: String, _type: ButtonType) -> BaseBtn:
#var new_btn: BaseBtn = BTN_SCENE.instantiate()
#new_btn.set_value(_value)
#new_btn.set_type(_type)
#return new_btn
func set_value(new_value: String) -> void:
	value = new_value


func set_type(new_type: ButtonType) -> void:
	type = new_type


func get_value() -> String:
	return value


func _on_button_pressed() -> void:
	pass # Replace with function body.
