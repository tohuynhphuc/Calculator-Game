class_name TreeNode

enum NodeType {
	EXPRESSION,
	NUMBER,
	OPERATOR,
	FUNCTION,
	BRACKET,
	FRACTION,
	CURSOR,
}

var children: Array[TreeNode] = []
var value = null
var type: NodeType
var is_closed_by_user: bool = false


func add_child(child_value, child_type) -> void:
	var new_node: TreeNode = TreeNode.new()
	new_node.value = child_value
	new_node.type = child_type
	children.append(new_node)


func add_child_node(node: TreeNode) -> void:
	children.append(node)


func remove_child(id) -> void:
	children.remove_at(id)
