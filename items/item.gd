extends Node


@export var stats : InventoryItem
@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var static_body_3d: StaticBody3D = $StaticBody3D
@onready var hitbox: CollisionShape3D = $StaticBody3D/CollisionShape3D
@onready var pickup_sound_player: AudioStreamPlayer3D = $PickupSoundPlayer

# get the player from the scene
@onready var player = get_tree().get_first_node_in_group("player")

signal interactedItem(stats)

func _ready() -> void:
	
	# connect the players interacted signal to any item in the scene
	player.interactedWithItem.connect(addItem)
	
	# set the sprites texture/hitbox/sfx to the stats outlined in the InventoryItem resource
	# this allows you to create new resources for items instead of making new items that inherit, and allows
	# items to not have any of these values if you dont want them to
	sprite_3d.set_texture(stats.icon)
	hitbox.shape.size = stats.hitbox_size
	pickup_sound_player.stream = stats.pickup_sound
	pass


func _process(delta: float) -> void:
	pass

## despite the name, does not actually add the item to anything, rather sends a signal to the 
## inventory manager to do so, making this implementation of items be agnostic to the inventory manager.
## it could work with any kind of inventory management system as long as it had a method to process the item resource
func addItem(item) -> void:
	
	# if the item is this item
	if item == static_body_3d:
		# wait for a frame because doing physics operations on the current frame is bad
		await Engine.get_main_loop().process_frame
		# signal out to the inventory manager
		interactedItem.emit(stats)
		# delete itself at the end of the current frame
		call_deferred("free")
	else:
		print("not the item")

## special use case, when an item needs to be removed from the players inventory it is called in the same way
func removeItem():
	interactedItem.emit(stats)
