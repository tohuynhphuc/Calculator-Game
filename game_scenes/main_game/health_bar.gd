extends ProgressBar


func _ready() -> void:
	max_value = GameManager.max_health


func _process(_delta: float) -> void:
	value = GameManager.health
