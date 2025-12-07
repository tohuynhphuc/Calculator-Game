class_name NumberDisplay
extends PanelContainer

@export var label: Label

var value: int
var is_allow_use: bool = false


func update() -> void:
	label.text = str(value)


func set_value(number: int) -> void:
	value = number
