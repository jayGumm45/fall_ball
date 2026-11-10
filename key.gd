extends Area2D

@onready var key_sound: AudioStreamPlayer2D = $KeySound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#key_sound.play()
	#body_entered.connect(_on_body_entered)




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		key_sound.play()
		hide()
		GameState.collect_key()
		await key_sound.finished
		queue_free()
		
