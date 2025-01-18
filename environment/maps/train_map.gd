extends Node3D

@onready var world_environment: WorldEnvironment = $WorldEnvironment

@onready var player: CharacterBody3D = $Player


func _ready() -> void:
	world_environment.environment.fog_enabled = true
	
	pass


func _process(delta: float) -> void:
	pass
