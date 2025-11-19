extends Node2D

@onready var grid: GridContainer = $GridContainer

var number_button_arr: Array[int] = [1, 2, 3, 4, 5, 6]

@export var grid_size_x = 120
@export var grid_size_y = 90
@export var grid_cols = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in number_button_arr.size():
		var button = NumberBtn.new_btn(number_button_arr[i])
		button.position = calculate_grid_position(i, grid_cols, grid_size_x, grid_size_y)
		grid.add_child(button)
		print(button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func calculate_grid_position(idx: int, cols: int, size_x: int, size_y: int) -> Vector2:
	var grid_pos = Vector2()
	grid_pos.x = size_x * (idx % cols)
	grid_pos.y = size_y * floor(idx / cols)
	return grid_pos
