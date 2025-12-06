extends Node2D

var number_buttons: Array

var base_deck_file_path = "res://objects/classes/number/base_deck.json"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	number_buttons = load_json(base_deck_file_path)
	#print("PARSING COMPLETE")
	#print(number_buttons)


func load_json(path: String) -> Array:
	var file = FileAccess.open(path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	return data


func load_csv_to_dictionary(path: String) -> Array:
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open CSV: %s" % path)
		return []
	
	var lines = file.get_as_text().strip_edges().split("\n", false)
	for i in range(lines.size()):
		lines[i] = lines[i].strip_edges()
	
	if lines.is_empty():
		return []
	
	var headers = lines[0].split(",", false)
	var result: Array = []
	
	for i in range(1, lines.size()):
		var row = lines[i].split(",", false)
		var dict := {}
		
		for col in range(headers.size()):
			var key = headers[col]
			var value = row[col] if col < row.size() else ""
			dict[key] = value
		
		result.append(dict)
	return result
