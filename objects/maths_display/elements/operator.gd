class_name OperatorDisplay
extends PanelContainer

@export var label: Label

var value


func update() -> void:
	label.text = str(value)


func set_value(number) -> void:
	value = number
