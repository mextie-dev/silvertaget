extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")

@onready var hitbox: StaticBody3D = $Hitbox

var doorOpen := false

func _ready() -> void:
	player.interactedWithDoor.connect(open)

func open(door):
	if door == hitbox:
		if doorOpen:
			return
		
		doorOpen = true
		rotation_degrees.y += 90
		$DoorOpenSound.play()
		await get_tree().create_timer(10).timeout
		rotation_degrees.y -= 90
		doorOpen = false
		
		
