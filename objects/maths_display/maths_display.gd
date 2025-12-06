extends PanelContainer

@export var container: Container

@onready var _brackets = preload("res://objects/maths_display/elements/brackets.tscn")
@onready var _expression = preload("res://objects/maths_display/elements/expression.tscn")
@onready var _function = preload("res://objects/maths_display/elements/function.tscn")
@onready var _number = preload("res://objects/maths_display/elements/number.tscn")
@onready var _operator = preload("res://objects/maths_display/elements/operator.tscn")
@onready var _cursor = preload("res://objects/maths_display/cursor.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.equation_changed.connect(display_tree)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func display_tree() -> void:
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

	var objects = from_tree_to_nodes(GameManager.get_tree_from_expression()[0])
	for obj in objects:
		container.add_child(obj)

	var cursor = _cursor.instantiate()
	insert_at_virtual_index(container, cursor, GameManager.cursor_position)


func should_expand(n: Node) -> bool:
	return n is Container and (n is not PanelContainer or n is BracketDisplay)


func flatten(node: Node, output: Array) -> void:
	for i in node.get_child_count():
		var child = node.get_child(i)
		if should_expand(child):
			flatten(child, output)
		else:
			output.append(
				{
					"node": child.get_child(0),
					"parent": node,
					"index": i,
				},
			)


func insert_at_virtual_index(root: Node, to_be_insert: Node, id: int) -> void:
	var flat := []
	flatten(root, flat)
	print(flat)

	if id < 0 or id > flat.size():
		print("Index out of range: ", id, " max: ", flat.size(), " min: ", 0)
		return

	if id == flat.size():
		root.add_child(to_be_insert)
		return

	var entry = flat[id]
	var parent = entry["parent"]
	var child_index = entry["index"]

	parent.add_child(to_be_insert)
	parent.move_child(to_be_insert, child_index)


func from_tree_to_nodes(root: TreeNode) -> Array:
	var objects: Array[Control] = []

	for child in root.children:
		if child.type == TreeNode.NodeType.NUMBER:
			var number = _number.instantiate()
			print("maths_display/from_tree_to_node")
			print(child)
			number.set_value(int(child.value.value))
			number.update()
			objects.append(number)

		elif child.type == TreeNode.NodeType.OPERATOR:
			var operator = _operator.instantiate()
			operator.value = child.value
			operator.update()
			objects.append(operator)

		elif child.type == TreeNode.NodeType.FUNCTION:
			var function = _operator.instantiate()
			function.value = child.value
			function.update()
			objects.append(function)

		elif child.type == TreeNode.NodeType.BRACKET:
			var bracket = _brackets.instantiate()
			var inside_bracket = from_tree_to_nodes(child)
			print(inside_bracket)
			bracket.expression = inside_bracket
			bracket.update(child.is_closed_by_user)
			objects.append(bracket)

		else:
			print("Unexpected child")

	return objects
