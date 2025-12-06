extends Control

class_name UIController

@export var number_container: Container
@export var equation_container: Container


func number_container_add_button(btn: BaseBtn) -> void:
	number_container.add_child(btn)


func equation_container_add_button(btn: BaseBtn) -> void:
	equation_container.add_child(btn)


func _on_submit_best_btn_pressed() -> void:
	EventBus.submit.emit(GameManager.best_results)


func _on_submit_current_btn_pressed() -> void:
	EventBus.submit.emit(GameManager.current_results)
