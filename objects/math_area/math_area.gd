extends Node2D

@onready var label = $Label

var characters: Array[String] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.number_button_clicked.connect(on_number_buttons_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var text = ""
	for char in characters:
		text += char
		text += " "
	label.text = text


func add_characters(char: String) -> void:
	characters.append(char)


func remove_characters(is_all: bool = false) -> void:
	if is_all:
		characters = []
		return
	characters.remove_at(characters.size() - 1)


func on_number_buttons_clicked(value: int) -> void:
	add_characters(str(value))
	print(value)
