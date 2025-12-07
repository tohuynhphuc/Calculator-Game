extends Control

@export var result: Label
@export var target: Label
@export var best_results: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.number_button_clicked.connect(on_number_buttons_clicked)
	EventBus.operator_button_clicked.connect(on_operator_buttons_clicked)
	EventBus.function_button_clicked.connect(on_function_buttons_clicked)
	EventBus.delete_button_clicked.connect(on_delete_buttons_clicked)

	target.text = str(GameManager.generated_target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	result.text = "" if GameManager.current_results == null else str(GameManager.current_results)
	best_results.text = "Best\n" + str(GameManager.best_results)


func add_characters(token: Variant) -> void:
	print("Adding characters: ", token, " at pos ", GameManager.cursor_position)
	GameManager.expression.insert(GameManager.cursor_position, token)
	print(GameManager.expression)


func remove_characters(is_all: bool = false) -> void:
	if is_all:
		while GameManager.expression.size() > 0:
			remove_at_pos()
		return
	remove_at_pos(GameManager.cursor_position - 1)


func remove_at_pos(pos: int = 0):
	var deleted_token = GameManager.expression.get(pos)
	if deleted_token is Number:
		for number_btn in GameManager.number_button_actual_btns:
			if number_btn.number_obj == deleted_token:
				number_btn.button.disabled = false
				break
	GameManager.expression.remove_at(pos)


func on_number_buttons_clicked(number: Number) -> void:
	print("NUMBER: ", number.value)
	add_characters(number)


func on_operator_buttons_clicked(operator: Operator) -> void:
	print("OPERATOR: ", operator.value)
	add_characters(operator)


func on_function_buttons_clicked(value: String) -> void:
	add_characters(value)
	GameManager.move_cursor_right()
	add_characters("(")
	GameManager.move_cursor_right()


func on_delete_buttons_clicked(is_all: bool) -> void:
	remove_characters(is_all)
