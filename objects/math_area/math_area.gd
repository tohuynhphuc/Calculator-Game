extends Control

@export var expression: Label
@export var result: Label
@export var target: Label

var characters: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.number_button_clicked.connect(on_buttons_clicked)
	EventBus.equation_button_clicked.connect(on_buttons_clicked)
	EventBus.function_button_clicked.connect(on_function_buttons_clicked)
	EventBus.delete_button_clicked.connect(on_delete_buttons_clicked)
	
	target.text = str(GameManager.generatedTarget)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var text = ""
	for char in characters:
		text += char
	expression.text = text
	GameManager.expression = characters
	
	if Calculator.evaluate_tokens(characters) == null:
		result.text = ""
	else:
		result.text = str(snapped(Calculator.evaluate_tokens(characters), 0.01))
	


func add_characters(char: String) -> void:
	#characters.append(char)
	characters.insert(GameManager.cursor_position, char)


func remove_characters(is_all: bool = false) -> void:
	if is_all:
		characters = []
		return
	characters.remove_at(GameManager.cursor_position - 1)


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
