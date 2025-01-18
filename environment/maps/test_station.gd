extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var train: Node3D = $Treain/train_car
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var world_environment: WorldEnvironment = $WorldEnvironment

var timesTeleported := 0
var trainArrived := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#arrive()
	$SilverKey.hide()
	$SilverKey.process_mode = Node.PROCESS_MODE_DISABLED
	
	world_environment.environment.fog_enabled = true
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	
	
func trainArrives():
	print("den här är när tåget kommer")
	arrive()

func startMoving():
	#if body == player:
	animation_player.speed_scale = 0.0
	animation_player.play("start")
	var tween = get_tree().create_tween()
	tween.tween_property(animation_player, "speed_scale", 1, 10)

func arrive():
	animation_player.speed_scale = 1
	animation_player.play_backwards("start")
	var tween = get_tree().create_tween()
	tween.tween_property(animation_player, "speed_scale", 0.2, 15)

func disableBarrier(anim):
	if anim == "start":
		print("worked")
		$DoorBarrier.process_mode = Node.PROCESS_MODE_DISABLED

func exitArea(body):
	if body == player:
		animation_player.play("fadeOut")
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://ui/start_train_sequence_cutscene.tscn")
