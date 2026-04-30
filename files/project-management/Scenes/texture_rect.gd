extends TextureRect

@export var atlas_texture: Texture2D
@export var x_index: int = 0
@export var y_index: int = 0
@export var icon_size: int = 32

var atlas: AtlasTexture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atlas = AtlasTexture.new()
	atlas.atlas = atlas_texture
	texture = atlas
	update_region()

func update_region():
	var x_index = randi_range(0, 2) * icon_size
	
	atlas.region = Rect2(x_index, y_index, icon_size, icon_size)
