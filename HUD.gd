extends CanvasLayer

@onready var key_icon: TextureRect = $KeyIcon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	key_icon.visible = GameState.has_key
	GameState.key_collected.connect(_on_key_collected)
	GameState.key_used.connect(_on_key_used)

func _on_key_collected() -> void:
	key_icon.visible = true

func _on_key_used() -> void:
	key_icon.visible = false
