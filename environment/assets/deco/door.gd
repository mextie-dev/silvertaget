extends Node3D

# gets player from scene
@onready var player = get_tree().get_first_node_in_group("player")

@onready var hitbox: StaticBody3D = $Hitbox

@export var locked := false

var doorOpen := false

# connects players door interaction to any doors in the scene
func _ready() -> void:
	player.interactedWithDoor.connect(open)

func open(door):
	# if door interacted with is this door
	if door == hitbox:
		
		# if open do nothing
		if doorOpen:
			return
		
		# if locked show locked text
		if locked:
			$LockedText.show()
			await get_tree().create_timer(3).timeout
			$LockedText.hide()
			return
		
		# play door open animation, close after 10 seconds
		doorOpen = true
		rotation_degrees.y += 90
		$DoorOpenSound.play()
		await get_tree().create_timer(10).timeout
		rotation_degrees.y -= 90
		doorOpen = false
		
		
