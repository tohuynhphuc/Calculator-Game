extends Control

var generatedTarget: int
var minValue: int = 100
var maxValue: int = 999

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generateTargetNumber()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func generateTargetNumber() -> void:
	generatedTarget = randi() % (maxValue - minValue + 1) + minValue
