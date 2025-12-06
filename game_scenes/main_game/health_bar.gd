extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    max_value = GameManager.max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    value = GameManager.health
