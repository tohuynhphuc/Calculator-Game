extends Control

@export var result: Label
@export var target: Label
@export var best_results: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.number_button_clicked.connect(on_buttons_clicked)
	EventBus.equation_button_clicked.connect(on_buttons_clicked)
	EventBus.function_button_clicked.connect(on_function_buttons_clicked)
	EventBus.delete_button_clicked.connect(on_delete_buttons_clicked)
	
	target.text = str(GameManager.generated_target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	result.text = "" if GameManager.current_results == null else str(GameManager.current_results)
	best_results.text = "Best\n" + str(GameManager.best_results)


func add_characters(char: String) -> void:
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
	GameManager.move_cursor_right()
	add_characters("(")
	GameManager.move_cursor_right()


func on_delete_buttons_clicked(is_all: bool) -> void:
	remove_characters(is_all)
