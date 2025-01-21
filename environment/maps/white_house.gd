extends Node3D

@onready var world_environment : WorldEnvironment = $WorldEnvironment
@onready var player: CharacterBody3D = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_environment.environment.fog_enabled = true
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == player:
		await get_tree().create_timer(60).timeout
		exitScene()

func exitScene():
	var tween = get_tree().create_tween()
	
	tween.tween_property(world_environment.environment, "fog_depth_end", 0.1, 5)
	
	pass
