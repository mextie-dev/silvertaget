extends Node3D

@onready var world_environment : WorldEnvironment = $WorldEnvironment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_environment.environment.fog_enabled = true
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass