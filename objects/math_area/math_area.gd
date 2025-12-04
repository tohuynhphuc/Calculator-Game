extends Control

@export var result: Label
@export var target: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.number_button_clicked.connect(on_buttons_clicked)
	EventBus.equation_button_clicked.connect(on_buttons_clicked)
	EventBus.function_button_clicked.connect(on_function_buttons_clicked)
	EventBus.delete_button_clicked.connect(on_delete_buttons_clicked)
	
	target.text = str(GameManager.generatedTarget)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Calculator.evaluate_tokens(GameManager.expression) == null:
		result.text = ""
	else:
		result.text = str(snapped(Calculator.evaluate_tokens(GameManager.expression), 0.01))
	


func add_characters(char: String) -> void:
	#characters.append(char)
	GameManager.expression.insert(GameManager.cursor_position, char)


func remove_characters(is_all: bool = false) -> void:
	if is_all:
		GameManager.expression = []
		return
	GameManager.expression.remove_at(GameManager.cursor_position - 1)


func on_buttons_clicked(value: String) -> void:
	print(value)
	add_characters(value)


func on_function_buttons_clicked(value: String) -> void:
	add_characters(value)
	add_characters("(")
	add_characters(")")
	GameManager.move_cursor_left()


func on_delete_buttons_clicked(is_all: bool) -> void:
	remove_characters(is_all)
