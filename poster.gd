extends Decal

@export var texture : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_albedo = texture
