extends Node2D

@export var number_grid: GridContainer
@export var equation_grid: GridContainer

var number_button_arr: Array[String] = ["1", "2", "3", "4", "5", "6"]
var equation_button_arr: Array[String] = ["+", "-", "*", "/", "(", ")"]

#@export var grid_size_x = 120
#@export var grid_size_y = 90
#@export var number_grid_cols = 5
#@export var equation_grid_cols = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in number_button_arr.size():
		var button = NumberBtn.new_btn(str(number_button_arr[i]))
		#button.position = calculate_grid_position(i, number_grid_cols, grid_size_x, grid_size_y)
		number_grid.add_child(button)
		print(button.get_value())
	
	for i in equation_button_arr.size():
		var button = EquationBtn.new_btn(str(equation_button_arr[i]))
		#button.position = calculate_grid_position(i, equation_grid_cols, grid_size_x, grid_size_y)
		equation_grid.add_child(button)
		print(button.get_value())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func calculate_grid_position(idx: int, cols: int, size_x: int, size_y: int) -> Vector2:
	var grid_pos = Vector2()
	grid_pos.x = size_x * (idx % cols)
	grid_pos.y = size_y * floor(idx / cols)
	return grid_pos
