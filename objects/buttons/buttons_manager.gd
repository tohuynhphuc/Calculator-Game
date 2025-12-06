extends Control

@export var ui_controller: UI_Controller

func _ready() -> void:
	generate_deck()
	GameManager.number_button_arr = get_k_random_buttons(GameManager.deck_size)
	
	add_buttons_to_scene()


func _process(delta: float) -> void:
	pass


func generate_deck() -> void:
	print("GENERATING DECK")
	for dict in Parser.number_buttons:
		GameManager.all_buttons_arr.append(Number.new(dict))


func get_k_random_buttons(k: int) -> Array:
	if k <= 0:
		return []
	if k > GameManager.all_buttons_arr.size():
		k = GameManager.all_buttons_arr.size()

	var temp = GameManager.all_buttons_arr.duplicate()
	temp.shuffle()

	return temp.slice(0, k)


func add_buttons_to_scene() -> void:
	for i in GameManager.number_button_arr.size():
		var button = NumberBtn.new_btn(GameManager.number_button_arr[i])
		ui_controller.number_container_add_button(button)
		GameManager.number_button_actual_btns.append(button)
	
	for i in GameManager.equation_button_arr.size():
		var button = EquationBtn.new_btn(GameManager.equation_button_arr[i])
		ui_controller.equation_container_add_button(button)
	
	for i in GameManager.comma_button_arr.size():
		ui_controller.equation_container_add_button(EquationBtn.new_btn(GameManager.comma_button_arr[i]))
	
	var left_bracket = BracketBtn.new_btn("(")
	left_bracket.set_orientation(true)
	ui_controller.equation_container_add_button(left_bracket)
	
	var right_bracket = BracketBtn.new_btn(")")
	right_bracket.set_orientation(false)
	ui_controller.equation_container_add_button(right_bracket)
	
	for i in GameManager.function_button_arr.size():
		var button = FunctionBtn.new_btn(GameManager.function_button_arr[i])
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
