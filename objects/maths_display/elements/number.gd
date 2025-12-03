#class_name Number
extends Control

@export var label: Label
var value
var isUpdate: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isUpdate:
		update()

func update() -> void:
	label.text = str(value)
	isUpdate = false


func set_value(number) -> void:
	value = number


func need_to_update() -> void:
	isUpdate = true
