extends Control

var expression: Array[Control]
@export var container: Container
var isUpdate: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isUpdate:
		update()
		


func update() -> void:
	for child in container.get_children():
		child.queue_free()
		#child.hide()
		#print(child.is)
		#container.remove_child(child)
	
	for token in expression:
		print(token)
		if container.get_children().has(token):
			print("HAS")
			token.show()
			container.add_child(token)
			print("Parent: ")
			print(token.get_parent())
		else:
			print("DON'T HAVE")
			container.add_child(token)
	
	isUpdate = false

func need_to_update() -> void:
	isUpdate = true
