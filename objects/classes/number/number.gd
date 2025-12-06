class_name Number

@export var value: int
@export var cost: int

func _init(dict: Dictionary) -> void:
	value = int(dict["value"])
	cost = int(dict["cost"])
