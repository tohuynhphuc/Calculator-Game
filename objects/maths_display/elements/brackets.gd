class_name BracketDisplay
extends PanelContainer

@export var container: Container
@export var left_bracket: Container
@export var right_bracket: Container

var expression: Array[Control]


func update(is_right_bracket: bool) -> void:
	for child in container.get_children():
		child.queue_free()

	for token in expression:
		container.add_child(token)

	if is_right_bracket:
		right_bracket.show()
	else:
		right_bracket.hide()
