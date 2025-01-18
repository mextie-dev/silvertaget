extends Control

@export var scene : String

func startGame():
	get_tree().change_scene_to_file(scene)
