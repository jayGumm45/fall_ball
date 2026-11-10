extends Node

signal key_collected
signal key_used

signal health_changed(current: int, maximum: int)
signal player_died

var has_key := false

var max_health := 6
var health := 6

func collect_key() -> void:
	if has_key:
		return
	has_key=true
	key_collected.emit()
	
func use_key() -> void:
	has_key = false
	key_used.emit()
	
func damage(amount :=1) -> void:
	if health <= 0:
		return
	health = max(health - amount, 0)
	health_changed.emit(health, max_health)
	if health == 0:
		player_died.emit()
	
func heal(amount := 1) -> void:
	health = min(health + amount, max_health)
	health_changed.emit(health, max_health)
	
func reset() -> void:
	health = max_health
	has_key = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
