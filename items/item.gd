extends Node


@export var stats : InventoryItem
@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var static_body_3d: StaticBody3D = $StaticBody3D
@onready var hitbox: CollisionShape3D = $StaticBody3D/CollisionShape3D
@onready var pickup_sound_player: AudioStreamPlayer3D = $PickupSoundPlayer

@onready var player = get_tree().get_first_node_in_group("player")

signal interactedItem(stats)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.interactedWithItem.connect(addItem)
	
	sprite_3d.set_texture(stats.icon)
	hitbox.shape.size = stats.hitbox_size
	pickup_sound_player.stream = stats.pickup_sound
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# remember to put item back in this method
func addItem(item) -> void:
	if item == static_body_3d:
		await Engine.get_main_loop().process_frame
		interactedItem.emit(stats)
		call_deferred("free")
	else:
		print("not the item")

func removeItem():
	interactedItem.emit(stats)
