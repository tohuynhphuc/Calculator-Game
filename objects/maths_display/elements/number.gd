class_name NumberDisplay
extends PanelContainer

@export var label: Label
var value: int

var is_allow_use: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update() -> void:
	label.text = str(value)


func set_value(number: int) -> void:
	value = number
