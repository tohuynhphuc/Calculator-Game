class_name BracketDisplay
extends PanelContainer

var expression: Array[Control]
@export var container: Container
@export var left_bracket: Container
@export var right_bracket: Container
var isUpdate: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		


func update(is_right_bracket: bool) -> void:
	for child in container.get_children():
		child.queue_free()
	
	for token in expression:
		#print(token)
		#if container.get_children().has(token):
			#print("HAS")
			#token.show()
			#container.add_child(token)
			#print("Parent: ")
			#print(token.get_parent())
		#else:
		#print("DON'T HAVE")
		container.add_child(token)
	
	if is_right_bracket:
		right_bracket.show()
	else:
		right_bracket.hide()
	isUpdate = false
