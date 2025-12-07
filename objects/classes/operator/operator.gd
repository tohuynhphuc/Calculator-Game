class_name Operator

@export var value: String
@export var precedence: int
@export var associativity: String
@export var arity: int
@export var is_postfix: bool = false
@export var is_locked: bool = false

var calculate_func
var operator_functions = {
	"add": func(a, b): return a + b,
	"subtract": func(a, b): return a - b,
	"multiply": func(a, b): return a * b,
	"divide": func(a, b): return a / b,
	"power": func(a, b): return pow(a, b),
	"unary_minus": func(a): return -a,
	"factorial": func(a):
		var res = 1
		for i in range(1, a + 1):
			res *= i
		return res,
}


func _init(dict: Dictionary) -> void:
	value = dict["value"]
	precedence = int(dict["precedence"])
	associativity = dict["assoc"]
	arity = int(dict["arity"])

	if operator_functions.has(dict["calculate"]):
		calculate_func = operator_functions[dict["calculate"]]

	if dict.has("is_postfix"):
		is_postfix = dict["is_postfix"]

	if dict.has("is_locked"):
		is_locked = dict["is_locked"]
