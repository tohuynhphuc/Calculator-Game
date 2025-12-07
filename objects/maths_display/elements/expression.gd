class_name ExpressionDisplay
extends PanelContainer

@export var container: Container

var elements: Array


func update() -> void:
	for child in container.get_children():
		child.queue_free()

	for token in elements:
		container.add_child(token)
