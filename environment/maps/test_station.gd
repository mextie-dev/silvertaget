extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var train: Node3D = $Treain/train_car
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var world_environment: WorldEnvironment = $WorldEnvironment

var timesTeleported := 0
var trainArrived := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var tween = get_tree().create_tween()
	
	fadeOutFog()
	
	$SilverKey.hide()
	$SilverKey.process_mode = Node.PROCESS_MODE_DISABLED
	
	
	
	#tween.tween_property(world_environment.environment, "fog_depth_end", 10, 7)
	
	pass

func fadeOutFog():
	var tween = get_tree().create_tween()
	world_environment.environment.fog_enabled = true
	world_environment.environment.fog_depth_end = 1
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(world_environment.environment, "fog_depth_end", 10, 7)

## because im a bad coder all the logic for this map is handled in process instead of its own function
## but this basically just gets the amount of times youve teleported and changes the sign and if the key is visible based on that
func _process(delta: float) -> void:
	if !trainArrived:
		if timesTeleported == 0:
			$SignNackrosen.show()
			$SignHusby.hide()
			$SignKista.hide()
			$SignKynlinge.hide()
		elif timesTeleported == 1:
			$SignNackrosen.hide()
			$SignHusby.show()
			$SignKista.hide()
			$SignKynlinge.hide()
		elif timesTeleported == 2:
			$SignNackrosen.hide()
			$SignHusby.hide()
			$SignKista.show()
			$SignKynlinge.hide()
			
			#show the silver key
			if $SilverKey:
				$SilverKey.show()
				$SilverKey.process_mode = Node.PROCESS_MODE_INHERIT
			else:
				pass
			
		elif timesTeleported == 3:
			$SignNackrosen.hide()
			$SignHusby.hide()
			$SignKista.hide()
			$SignKynlinge.show()
		elif timesTeleported == 4:
			trainArrives()
			trainArrived = true
		else:
			print("den här är fucked")

#region Teleport code, loops the station and increments the times teleported

func teleportPlayerPositiveZ(body):
	if body == player:
		if timesTeleported < 4:
			var tween = get_tree().create_tween().bind_node(self)
			tween.set_parallel(true)
			#player.x = player.x - 10
			player.position.z = player.position.z + 80
			timesTeleported += 1
		else:
			player.position.z = player.position.z + 80

func teleportPlayerNegativeZ(body):
	if body == player:
		if timesTeleported < 4:
			#player.x = player.x - 10
			player.position.z = player.position.z - 80
			timesTeleported += 1
		else:
			player.position.z = player.position.z - 80
#endregion

## called when player has teleported four times
func trainArrives():
	print("den här är när tåget kommer")
	arrive()

## starts the train movement cutscene
func startMoving():
	#if body == player:
	animation_player.speed_scale = 0.0
	animation_player.play("start")
	var tween = get_tree().create_tween()
	tween.tween_property(animation_player, "speed_scale", 1, 10)

## actually makes the train arrive i have no idea why this is in two functions im so fucking bad at coding
func arrive():
	animation_player.speed_scale = 1
	animation_player.play_backwards("start")
	var tween = get_tree().create_tween()
	tween.tween_property(animation_player, "speed_scale", 0.2, 15)

## disables the platform barrier when the train arrives
func disableBarrier(anim):
	if anim == "start":
		print("worked")
		$DoorBarrier.process_mode = Node.PROCESS_MODE_DISABLED

## exits the area when the train has gone for long enough
func exitArea(body):
	if body == player:
		animation_player.play("fadeOut")
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://ui/start_train_sequence_cutscene.tscn")
