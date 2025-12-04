class_name FunctionDisplay
extends Container

var elements: Array
@export var container: Container

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update() -> void:
	for child in container.get_children():
		child.queue_free()
	
	for token in elements:
		container.add_child(token)
