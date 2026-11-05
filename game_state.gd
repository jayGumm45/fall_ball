extends Node

signal key_collected

signal key_used

var has_key := false

func collect_key() -> void:
	if has_key:
		return
	has_key=true
	key_collected.emit()
	
func use_key() -> void:
	has_key = false
	key_used.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
