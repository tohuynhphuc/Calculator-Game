class_name Operators

# Operator metadata
# precedence: higher = stronger binding
# associativity: "left" or "right"
# arity: number of operands

static var OPERATORS = {
	"+":  {"precedence": 1, "assoc": "left",  "arity": 2, "func": func(a, b): return a + b},
	"-":  {"precedence": 1, "assoc": "left",  "arity": 2, "func": func(a, b): return a - b},
	"*":  {"precedence": 2, "assoc": "left",  "arity": 2, "func": func(a, b): return a * b},
	"/":  {"precedence": 2, "assoc": "left",  "arity": 2, "func": func(a, b): return a / b},
	"^":  {"precedence": 3, "assoc": "right", "arity": 2, "func": func(a, b): return pow(a, b)},

	"u-": {"precedence": 4, "assoc": "right", "arity": 1, "func": func(a): return -a},

	"!":  {"precedence": 4, "assoc": "right", "arity": 1, "func": func(a): return factorial(a)},
}

static var POSTFIX = ["!"]

# Registered functions (min, max, sin, cos, tan, etc)
static var FUNCTIONS = {
	"sin": func(a): return sin(a),
	"cos": func(a): return cos(a),
	"tan": func(a): return tan(a),
	"min": func(a, b): return min(a, b),
	"max": func(a, b): return max(a, b),
}

static func factorial(a: int) -> int:
	var prod = 1
	for i in range(a):
		prod *= (i + 1)
	return prod
