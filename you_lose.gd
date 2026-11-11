extends CanvasLayer

@onready var lose_sound: AudioStreamPlayer = $GameOver

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.player_died.connect(_on_lose)

func _on_lose() -> void:
	visible = true
	get_tree().paused = true
	lose_sound.play()
