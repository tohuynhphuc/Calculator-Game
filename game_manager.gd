extends Control

var generatedTarget: int
var minValue: int = 100
var maxValue: int = 999
var expression: Array[String]

var cursor_position: int = 0

func _ready() -> void:
	generate_target_number()


func _process(delta: float) -> void:
	pass


func generate_target_number() -> void:
	generatedTarget = randi() % (maxValue - minValue + 1) + minValue


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
