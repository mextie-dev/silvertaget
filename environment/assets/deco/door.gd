extends Node3D

# gets player from scene
@onready var player = get_tree().get_first_node_in_group("player")

@onready var hitbox: StaticBody3D = $Hitbox

@export var locked := false
@export var stuck := false

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
			$MarginContainer/StuckText.visible = not visible
			$MarginContainer/LockedText.show()
			$DoorLockedSound.play()
			await get_tree().create_timer(3).timeout
			$MarginContainer/LockedText.hide()
			return
		# PLEASE I BEG YOU
		if stuck:
			$MarginContainer/LockedText.visible = not visible
			$MarginContainer/StuckText.show()
			$DoorStuckSound.play()
			await get_tree().create_timer(3).timeout
			$MarginContainer/StuckText.hide()
			return
		
		# play door open animation, close after 10 seconds
		doorOpen = true
		rotation_degrees.y += 90
		$DoorOpenSound.play()
		await get_tree().create_timer(10).timeout
		rotation_degrees.y -= 90
		doorOpen = false
		
		
