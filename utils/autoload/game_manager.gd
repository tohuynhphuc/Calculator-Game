extends Control

var generated_target: int
var min_value: int = 100
var max_value: int = 999
var expression: Array[Variant]
var max_health: int = 20
var health: int
var cursor_position: int = 0
var best_results: float = 0
var current_results: Variant = 0
var all_buttons_arr: Array[Number]
var number_button_arr: Array[Number] = []
var number_button_actual_btns: Array[NumberBtn] = []
##### DECK #####
var equation_button_arr: Array[String] = ["+", "-", "*", "/", "^", "!"]
var comma_button_arr: Array[String] = [","]
var bracket_button_arr: Array[String] = ["(", ")"]
var function_button_arr: Array[String] = ["sin", "cos", "tan"]
var deck_size: int = 5


func _ready() -> void:
	generate_target_number()
	health = max_health

	EventBus.submit.connect(submit)


func _process(_delta: float) -> void:
	update_results()


func generate_target_number() -> void:
	generated_target = randi() % (max_value - min_value + 1) + min_value


func update_results() -> void:
	if Calculator.evaluate_tokens(GameManager.expression) == null:
		current_results = null
		return
	current_results = snapped(Calculator.evaluate_tokens(GameManager.expression), 0.01)
	if abs(current_results - generated_target) <= abs(best_results - generated_target):
		best_results = current_results


func get_tree_from_expression(
		start_id: int = 0,
		type: TreeNode.NodeType = TreeNode.NodeType.EXPRESSION,
) -> Array:
	var root: TreeNode = TreeNode.new()
	root.type = type
	var i: int = start_id
	var n: int = expression.size()
	print(expression)
	print(n)
	while i < n:
		var token = expression[i]
		if token is Number:
			root.add_child(token, TreeNode.NodeType.NUMBER)

		elif Operators.operators.has(token):
			root.add_child(token, TreeNode.NodeType.OPERATOR)

		elif token == Operators.comma:
			root.add_child(token, TreeNode.NodeType.OPERATOR)

		elif Operators.functions.has(token):
			root.add_child(token, TreeNode.NodeType.FUNCTION)

		elif token == Operators.left_bracket:
			var res = get_tree_from_expression(i + 1, TreeNode.NodeType.BRACKET)
			res[0].is_closed_by_user = res[2]
			root.add_child_node(res[0])
			i = res[1]

		elif token == Operators.right_bracket:
			if type == TreeNode.NodeType.BRACKET:
				return [root, i, true]
			# this is a ) without any (
			root.add_child(token, TreeNode.NodeType.OPERATOR)

		else:
			print("Unknown token")
		i += 1
	return [root, i, false]


func move_cursor_right(change: int = 1) -> void:
	cursor_position += change
	if cursor_position > expression.size():
		cursor_position = expression.size()


func move_cursor_left(change: int = 1) -> void:
	cursor_position -= change
	if cursor_position < 0:
		cursor_position = 0


func submit(answer: Variant) -> void:
	if answer == null:
		print("NULL results, can't submit")
		return
	health -= floor(abs(answer - generated_target))
