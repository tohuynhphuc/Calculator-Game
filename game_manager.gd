extends Control

var generatedTarget: int
var minValue: int = 100
var maxValue: int = 999
var expression: Array[String]

var cursor_position: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_target_number()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func generate_target_number() -> void:
	generatedTarget = randi() % (maxValue - minValue + 1) + minValue


func get_tree_from_expression(start_id: int = 0, type: TreeNode.NODE_TYPE = TreeNode.NODE_TYPE.EXPRESSION) -> Array:
	var root: TreeNode = TreeNode.new()
	root.type = type
	var i: int = start_id
	var n: int = len(expression)
	while i < n:
		var token = expression[i]
		var node: TreeNode = TreeNode.new()
		if token.is_valid_float():
			root.add_child(token, TreeNode.NODE_TYPE.NUMBER)
		elif Operators.OPERATORS.has(token):
			root.add_child(token, TreeNode.NODE_TYPE.OPERATOR)
		elif Operators.FUNCTIONS.has(token):
			root.add_child(token, TreeNode.NODE_TYPE.FUNCTION)
		elif token == "(":
			var res = get_tree_from_expression(i + 1, TreeNode.NODE_TYPE.BRACKET)
			root.add_child_node(res[0])
			i = res[1]
		elif token == ")":
			return [root, i]
		i += 1
	return [root, i]


func move_cursor_right(change: int = 1) -> void:
	cursor_position += change
	if cursor_position > expression.size():
		cursor_position = expression.size()


func move_cursor_left(change: int = 1) -> void:
	cursor_position -= change
	if cursor_position < 0:
		cursor_position = 0
