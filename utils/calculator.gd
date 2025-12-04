class_name Calculator

static func evaluate(expression: String) -> Variant:
	if expression.strip_edges() == "":
		return null

	var tokens = tokenize(expression)
	if tokens.size() == 0:  # tokenizer failed or empty
		return null

	var processed = _process_unary_and_implicit(tokens)
	if processed.size() == 0:
		return null

	var rpn = infix_to_postfix(processed)
	if rpn == null or rpn.size() == 0:  # invalid infix
		return null

	var result = evaluate_postfix(rpn)
	if result == null:
		return null

	return result


static func evaluate_tokens(tokens: Array) -> Variant:
	if tokens.size() == 0:
		return null

	# Reject things like ["1","2"]
	if not validate_raw_tokens(tokens):
		return null

	var processed = _process_unary_and_implicit(tokens)
	if processed.size() == 0:
		return null

	var rpn = infix_to_postfix(processed)
	if rpn == null or rpn.size() == 0:
		return null

	var result = evaluate_postfix(rpn)
	if result == null:
		return null

	return result



static func validate_raw_tokens(tokens: Array) -> bool:
	if tokens.size() == 0:
		return false

	for i in tokens.size():
		var t = tokens[i]

		# A number
		if t.is_valid_float():
			# Look ahead: next token exists and is also a number?
			if i + 1 < tokens.size() and tokens[i+1].is_valid_float():
				return false  # two consecutive numbers → invalid

	return true


static func tokenize(expr: String) -> Array:
	var tokens: Array = []
	var i := 0
	expr = expr.strip_edges()

	var single_ops := ["+", "-", "*", "/", "^", "!", "(", ")", ","]

	while i < expr.length():
		var c := expr[i]

		# Skip spaces
		if c == " " or c == "\t":
			i += 1
			continue

		# --- NUMBER ---------------------------------------------------------
		if _is_digit(c) or (c == "." and i + 1 < expr.length() and _is_digit(expr[i+1])):
			var start = i
			i += 1
			while i < expr.length() and (_is_digit(expr[i]) or expr[i] == "."):
				i += 1
			tokens.append(expr.substr(start, i - start))
			continue

		# --- IDENTIFIER (function or variable) ------------------------------
		if _is_alpha(c):
			var start = i
			i += 1
			while i < expr.length() and (_is_alnum(expr[i]) or expr[i] == "_"):
				i += 1
			tokens.append(expr.substr(start, i - start))
			continue

		# --- OPERATORS / PARENS / COMMA ------------------------------------
		if single_ops.has(c):
			tokens.append(c)
			i += 1
			continue

		push_error("Invalid token at index %d: '%s'" % [i, c])
		return []
	
	return tokens


# ---- Character helpers (Godot 4) --------------------------------------------

static func _is_digit(c: String) -> bool:
	return c >= "0" and c <= "9"

static func _is_alpha(c: String) -> bool:
	return (c >= "a" and c <= "z") or (c >= "A" and c <= "Z")

static func _is_alnum(c: String) -> bool:
	return _is_alpha(c) or _is_digit(c)


# ---- Unary minus + implicit multiplication ----------------------------------

static func _process_unary_and_implicit(tokens: Array) -> Array:
	var out: Array = []
	var prev = null

	for t in tokens:
		var is_op := Operators.OPERATORS.has(t)
		var is_number: bool = t.is_valid_float()
		var is_ident: bool = _is_identifier(t)

		# UNARY MINUS
		if t == "-":
			if prev == null or (Operators.OPERATORS.has(prev) or prev == "(" or prev == ","):
				out.append("u-")
			else:
				out.append("-")
			prev = t
			continue

		# IMPLICIT MULTIPLICATION
		var insert_mul := false

		if prev != null:
			var prev_can_end = (prev.is_valid_float() or _is_identifier(prev)
					or prev == ")" or Operators.POSTFIX.has(prev))
			var t_can_start = (is_number or is_ident or t == "(")

			if prev_can_end and t_can_start:
				if not (_is_identifier(prev) and t == "("):
					insert_mul = true

		if insert_mul:
			out.append("*")

		out.append(t)
		prev = t

	return out


#static func _is_identifier(t: String) -> bool:
	#if t.is_valid_float(): return false
	#if t in ["+", "-", "*", "/", "^", "!", "u-", "(", ")", ","]: return false
	#return true
static func _is_identifier(t: String) -> bool:
	if t.is_valid_float():
		return false

	# Parentheses / commas are NOT identifiers
	if t == "(" or t == ")" or t == ",":
		return false

	# If it matches an operator token → NOT identifier
	if Operators.OPERATORS.has(t):
		return false

	# If it matches a registered function → NOT identifier
	if Operators.FUNCTIONS.has(t):
		return false

	# Everything else is treated as identifier
	return true


static func infix_to_postfix(tokens: Array) -> Variant:
	var output = []
	var stack = []

	for token in tokens:
		if token.is_valid_float():
			output.append(token)
		
		elif Operators.FUNCTIONS.has(token):
			stack.append(token)

		elif Operators.OPERATORS.has(token):
			var o1 = token
			while stack.size() > 0:
				var top = stack[-1]
				if Operators.OPERATORS.has(top):
					var o2 = top
					var p1 = Operators.OPERATORS[o1].precedence
					var p2 = Operators.OPERATORS[o2].precedence
					var assoc = Operators.OPERATORS[o1].assoc

					var cond_left  = assoc == "left"  and p1 <= p2
					var cond_right = p1 <  p2

					if cond_left or cond_right:
						output.append(stack.pop_back())
					else:
						break
				else:
					break
			stack.append(o1)

		elif token == ",":
			pass
		elif token == "(":
			stack.append(token)

		elif token == ")":
			var found_left_paren = false
			while stack.size() > 0:
				var top = stack.pop_back()
				if top == "(":
					found_left_paren = true
					break
				output.append(top)

			if not found_left_paren:
				return null  # invalid parentheses
			if stack.size() > 0 and Operators.FUNCTIONS.has(stack[-1]):
				output.append(stack.pop_back())

		else:
			return null  # unknown token

	while not stack.is_empty():
		var op = stack.pop_back()
		if op == "(":
			continue # ignore not closed parentheses (considered valid)
		elif op == ")":
			return null
		output.append(op)

	return output


static func evaluate_postfix(postfix: Array) -> Variant:
	if postfix == [null]:
		return null

	var stack = []

	for token in postfix:
		if token.is_valid_float():
			stack.append(float(token))

		elif Operators.OPERATORS.has(token):
			var arity = Operators.OPERATORS[token].arity

			if stack.size() < arity:
				return null

			if arity == 1:
				var a = stack.pop_back()
				stack.append(Operators.OPERATORS[token]["func"].call(a))

			elif arity == 2:
				var b = stack.pop_back()
				var a = stack.pop_back()
				stack.append(Operators.OPERATORS[token]["func"].call(a, b))

		elif Operators.FUNCTIONS.has(token):
			# We only support 1-2 args; extend if needed
			if stack.size() < 1:
				return null
			if Operators.FUNCTIONS[token].get_argument_count() == 1:
				var a = stack.pop_back()
				stack.append(Operators.FUNCTIONS[token].call(a))
			elif Operators.FUNCTIONS[token].get_argument_count() == 2:
				var b = stack.pop_back()
				var a = stack.pop_back()
				stack.append(Operators.FUNCTIONS[token].call(a, b))

		else:
			return null

	if stack.size() != 1:
		return null

	return stack[0]
