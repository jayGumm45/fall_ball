extends Area2D

@onready var collect_key: AudioStreamPlayer2D = $KeySound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameState.collect_key()
		queue_free()
		collect_key.play()
