class_name BaseBtn
extends Node2D

enum btn_type {
	NUMBER,
	EQUATION
}

var type : btn_type
var value: String

@onready var math_area = $MathArea
@onready var label = $Button/Label

const BTN_SCENE = preload("res://objects/buttons/base_btn.tscn")

static func new_btn(num: int) -> NumberBtn:
	var new_btn: NumberBtn = BTN_SCENE.instantiate()
	new_btn.number = num
	return new_btn


func set_value(new_value: String) -> void:
	value = new_value


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
