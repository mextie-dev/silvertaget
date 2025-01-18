extends Control

@export var scene : String

## switches scene on end of cutscene, TODO change this whole script to cutscene_manager
func startGame():
	get_tree().change_scene_to_file(scene)
