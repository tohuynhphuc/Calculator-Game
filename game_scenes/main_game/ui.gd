extends Control
class_name UI_Controller

@export var number_container: Container
@export var equation_container: Container

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


func _on_submit_best_btn_pressed() -> void:
	EventBus.submit.emit(GameManager.best_results)


func _on_submit_current_btn_pressed() -> void:
	EventBus.submit.emit(GameManager.current_results)
