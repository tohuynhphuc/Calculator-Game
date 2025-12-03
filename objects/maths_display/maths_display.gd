extends Control

@onready var _brackets = preload("res://objects/maths_display/elements/brackets.tscn")
@onready var _expression = preload("res://objects/maths_display/elements/expression.tscn")
@onready var _function = preload("res://objects/maths_display/elements/function.tscn")
@onready var _number = preload("res://objects/maths_display/elements/number.tscn")

@export var container: Container

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.equation_changed.connect(display_tree)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func display_tree() -> void:
	for child in container.get_children():
		child.queue_free()
	var objects = from_tree_to_nodes(GameManager.get_tree_from_expression()[0])
	for obj in objects:
		container.add_child(obj)


func from_tree_to_nodes(root: TreeNode) -> Array:
	var objects: Array[Control] = []
	for child in root.children:
		if child.type == TreeNode.NODE_TYPE.NUMBER:
			var number = _number.instantiate()
			number.set_value(int(child.value))
			number.update()
			objects.append(number)
		elif child.type == TreeNode.NODE_TYPE.OPERATOR:
			# TODO: Create Operator Scene
			var operator = _number.instantiate()
			operator.value = child.value
			objects.append(operator)
			operator.update()
		elif child.type == TreeNode.NODE_TYPE.FUNCTION:
			var function = _function.instantiate()
			# TODO: Implement function
			function.update()
		elif child.type == TreeNode.NODE_TYPE.BRACKET:
			var bracket = _brackets.instantiate()
			var inside_bracket = from_tree_to_nodes(child)
			print(inside_bracket)
			bracket.expression = inside_bracket
			objects.append(bracket)
			bracket.update()
	return objects
