class_name BaseBtn
extends Control

enum btn_type {
	BASE,
	NUMBER,
	EQUATION,
	DELETE,
	ALL_CLEAR
}

var type : btn_type
var value: String

@onready var math_area = $MathArea
@onready var label = $Button/Label

const BTN_SCENE = preload("res://objects/buttons/base_btn.tscn")

static func new_btn(_value: String, _type: btn_type) -> BaseBtn:
	var new_btn: BaseBtn = BTN_SCENE.instantiate()
	new_btn.set_value(_value)
	new_btn.set_type(_type)
	return new_btn


func set_value(new_value: String) -> void:
	value = new_value


func set_type(new_type: btn_type) -> void:
	type = new_type


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if label.text != value:
		label.text = value


func get_value() -> String:
	return value
