extends CanvasLayer

@onready var key_icon: TextureRect = $KeyIcon

@onready var hearts: HBoxContainer = $Hearts

const heartIcons := preload("res://art/tilemap.png")
var full_tex := _atlas(4,2)
var half_tex := _atlas(5,2)
var empty_tex := _atlas(6,2)

func _atlas(col: int, row: int) -> AtlasTexture:
	var t := AtlasTexture.new()
	t.atlas = heartIcons
	t.region = Rect2(col * 19, row * 19, 18, 18)
	return t

func _update_hearts(current: int, maximum: int) -> void:
	var count := ceili(maximum / 2.0)
	while hearts.get_child_count() < count:
		var icon := TextureRect.new()
		icon.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		hearts.add_child(icon)
	for i in count:
		var left := current - i * 2
		var icon := hearts.get_child(i) as TextureRect
		icon.texture = full_tex if left >= 2 else (half_tex if left == 1 else empty_tex)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hearts.add_theme_constant_override("separation", 0)
	GameState.health_changed.connect(_update_hearts)
	_update_hearts(GameState.health, GameState.max_health)
	key_icon.visible = GameState.has_key
	GameState.key_collected.connect(_on_key_collected)
	GameState.key_used.connect(_on_key_used)

func _on_key_collected() -> void:
	key_icon.visible = true

func _on_key_used() -> void:
	key_icon.visible = false
