extends Control

@export var ui_controller: UI_Controller

var all_buttons_arr: Array[String]

var number_button_arr: Array[String] = []
var equation_button_arr: Array[String] = ["+", "-", "*", "/", "^", "!"]
var bracket_button_arr: Array[String] = ["(", ")"]
var function_button_arr: Array[String] = ["sin", "cos", "tan", "max", "min"]

var deck_size: int = 5


func _ready() -> void:
	generate_deck()
	number_button_arr = get_k_random_buttons(deck_size)
	
	add_buttons_to_scene()


func _process(delta: float) -> void:
	pass


func generate_deck() -> void:
	for i in range(50):
		all_buttons_arr.append(str(i + 1))


func get_k_random_buttons(k: int) -> Array:
	if k <= 0:
		return []
	if k > all_buttons_arr.size():
		k = all_buttons_arr.size()

	var temp = all_buttons_arr.duplicate()
	temp.shuffle()

	return temp.slice(0, k)


func add_buttons_to_scene() -> void:
	for i in number_button_arr.size():
		var button = NumberBtn.new_btn(number_button_arr[i])
		ui_controller.number_container_add_button(button)
	
	for i in equation_button_arr.size():
		var button = EquationBtn.new_btn(equation_button_arr[i])
		ui_controller.equation_container_add_button(button)
	
	ui_controller.equation_container_add_button(EquationBtn.new_btn(","))
	
	var left_bracket = BracketBtn.new_btn("(")
	left_bracket.set_orientation(true)
	ui_controller.equation_container_add_button(left_bracket)
	
	var right_bracket = BracketBtn.new_btn(")")
	right_bracket.set_orientation(false)
	ui_controller.equation_container_add_button(right_bracket)
	
	for i in function_button_arr.size():
		var button = FunctionBtn.new_btn(function_button_arr[i])
		ui_controller.equation_container_add_button(button)
	
	ui_controller.equation_container_add_button(DeleteBtn.new_btn("DEL"))
	ui_controller.equation_container_add_button(DeleteBtn.new_btn("AC", BaseBtn.btn_type.ALL_CLEAR))
	
	ui_controller.equation_container_add_button(LeftArrowBtn.new_btn())
	ui_controller.equation_container_add_button(RightArrowBtn.new_btn())


func calculate_grid_position(idx: int, cols: int, size_x: int, size_y: int) -> Vector2:
	var grid_pos = Vector2()
	grid_pos.x = size_x * (idx % cols)
	grid_pos.y = size_y * floor(idx / cols)
	return grid_pos
