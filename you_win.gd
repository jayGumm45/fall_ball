extends CanvasLayer

@onready var win_sound: AudioStreamPlayer = $VictorySound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.won.connect(_on_win)


func _on_win() -> void:
	visible = true
	get_tree().paused = true
	win_sound.play()
