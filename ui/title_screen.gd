extends Control

@onready var house_cam: Camera3D = $HouseBG/HouseCam
@onready var station_cam: Camera3D = $TrainBG/StationCam



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$OptionsScreen.hide()
	$TitleScreenUI.show()
	var check = Global.rng.randf_range(0, 3)
	if check > 1.5:
		house_cam.make_current()
	else:
		station_cam.make_current()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/opening_cutscene.tscn")


func _on_options_pressed() -> void:
	$OptionsScreen.show()
	$TitleScreenUI.hide()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_eng_lang_button_pressed() -> void:
	print("language switched to english")


func _on_sve_lang_button_pressed() -> void:
	print("language switched to swedish")
	# TODO: figure out how tf to translate the game


func _on_back_pressed() -> void:
	$OptionsScreen.hide()
	$TitleScreenUI.show()
