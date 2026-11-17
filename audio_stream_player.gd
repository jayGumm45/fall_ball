extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()
	GameState.won.connect(_on_win)
	GameState.player_died.connect(_on_lose)

func _on_win() -> void:
	stop()
	
func _on_lose() -> void:
	stop()
