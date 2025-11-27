extends Control
class_name UI_Controller

@export var number_container: GridContainer
@export var equation_container: GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func number_container_add_button(btn: BaseBtn) -> void:
	number_container.add_child(btn)


func equation_container_add_button(btn: BaseBtn) -> void:
	equation_container.add_child(btn)
