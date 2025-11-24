extends Node2D

@onready var label = $PanelContainer/MarginContainer/VBoxContainer/Expression

var characters: Array[String] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.number_button_clicked.connect(on_buttons_clicked)
	EventBus.equation_button_clicked.connect(on_buttons_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var text = ""
	for char in characters:
		text += char
	label.text = text


func add_characters(char: String) -> void:
	characters.append(char)


func remove_characters(is_all: bool = false) -> void:
	if is_all:
		characters = []
		return
	characters.remove_at(characters.size() - 1)


func on_buttons_clicked(value: String) -> void:
	add_characters(value)
	print(value)
