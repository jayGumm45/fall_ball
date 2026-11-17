extends Node

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Restart") and not event.is_echo():
		get_viewport().set_input_as_handled()
		get_tree().paused = false
		GameState.reset()
		get_tree().reload_current_scene()
