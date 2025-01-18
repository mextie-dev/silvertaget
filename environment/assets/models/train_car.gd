extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var player = get_tree().get_first_node_in_group("player")

var isDoorOpen := false

signal startMoving

## opens the train door
func openDoor(body):
	if isDoorOpen:
		return
	if body == player:
		animation_player.play("doorOpen")
		isDoorOpen = true

## closes the train door
func closeDoor(body):
	if !isDoorOpen:
		return
	if body == player:
		animation_player.play_backwards("doorOpen")
		isDoorOpen = false
		startMoving.emit()
