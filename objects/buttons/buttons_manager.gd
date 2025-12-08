extends Control

@export var ui_controller: UIController


func _ready() -> void:
	generate_deck()
	GameManager.number_button_arr = get_k_random_buttons(GameManager.deck_size)

	add_buttons_to_scene()


func generate_deck() -> void:
	print("GENERATING DECK")
	for dict in Parser.number_buttons:
		GameManager.all_buttons_arr.append(Number.new(dict))

	print("GENERATING OPERATORS")
	for dict in Parser.operators_buttons:
		GameManager.operator_button_arr.append(Operator.new(dict))

	print("GENERATE BRACKETS")
	GameManager.bracket_button_arr.append(Bracket.new(true, "("))
	GameManager.bracket_button_arr.append(Bracket.new(false, ")"))


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

	for i in GameManager.operator_button_arr.size():
		print(GameManager.operator_button_arr[i].value)
		if not GameManager.operator_button_arr[i].is_locked:
			var button = OperatorBtn.new_btn(GameManager.operator_button_arr[i])
			ui_controller.equation_container_add_button(button)
			# Don't need this
			# GameManager.operator_button_actual_btns.append(button)

	for i in GameManager.operator_button_arr.size():
		if GameManager.operator_button_arr[i].value == ",":
			ui_controller.equation_container_add_button(
				OperatorBtn.new_btn(GameManager.operator_button_arr[i]),
			)

	for i in GameManager.bracket_button_arr.size():
		var button = BracketBtn.new_btn(GameManager.bracket_button_arr[i])
		ui_controller.equation_container_add_button(button)

	for i in GameManager.function_button_arr.size():
		var button = FunctionBtn.new_btn(GameManager.function_button_arr[i])
		ui_controller.equation_container_add_button(button)

	ui_controller.equation_container_add_button(DeleteBtn.new_btn("DEL"))
	ui_controller.equation_container_add_button(
		DeleteBtn.new_btn("AC", BaseBtn.ButtonType.ALL_CLEAR),
	)

	ui_controller.equation_container_add_button(LeftArrowBtn.new_btn())
	ui_controller.equation_container_add_button(RightArrowBtn.new_btn())
# func calculate_grid_position(idx: int, cols: int, size_x: int, size_y: int) -> Vector2:
# 	var grid_pos = Vector2()
# 	grid_pos.x = size_x * (idx % cols)
# 	grid_pos.y = size_y * floor(idx / cols)
# 	return grid_pos
