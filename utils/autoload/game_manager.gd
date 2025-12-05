extends Control

var generated_target: int
var min_value: int = 100
var max_value: int = 999
var expression: Array[String]

var max_health: int = 20
var health: int

var cursor_position: int = 0
var best_results: float = 0
var current_results: Variant = 0

var all_buttons_arr: Array[String]

var number_button_arr: Array[String] = []
var equation_button_arr: Array[String] = ["+", "-", "*", "/", "^", "!"]
var comma_button_arr: Array[String] = [","]
var bracket_button_arr: Array[String] = ["(", ")"]
var function_button_arr: Array[String] = ["sin", "cos", "tan", "max", "min"]

var deck_size: int = 5

func _ready() -> void:
	generate_target_number()
	health = max_health


func _process(delta: float) -> void:
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


func get_tree_from_expression(start_id: int = 0,
		type: TreeNode.NODE_TYPE = TreeNode.NODE_TYPE.EXPRESSION) -> Array:
	var root: TreeNode = TreeNode.new()
	root.type = type
	var i: int = start_id
	var n: int = expression.size()
	print(expression)
	print(n)
	while i < n:
		var token = expression[i]
		if token.is_valid_float():
			root.add_child(token, TreeNode.NODE_TYPE.NUMBER)
		
		elif Operators.OPERATORS.has(token):
			root.add_child(token, TreeNode.NODE_TYPE.OPERATOR)
		
		elif token == Operators.COMMA:
			root.add_child(token, TreeNode.NODE_TYPE.OPERATOR)
		
		elif Operators.FUNCTIONS.has(token):
			root.add_child(token, TreeNode.NODE_TYPE.FUNCTION)
		
		elif token == Operators.LEFT_BRACKET:
			var res = get_tree_from_expression(i + 1, TreeNode.NODE_TYPE.BRACKET)
			res[0].is_closed_by_user = res[2]
			root.add_child_node(res[0])
			i = res[1]
		
		elif token == Operators.RIGHT_BRACKET:
			if type == TreeNode.NODE_TYPE.BRACKET:
				return [root, i, true]
			else: # this is a ) without any (
				root.add_child(token, TreeNode.NODE_TYPE.OPERATOR)
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
	health -= abs(answer - generated_target)
