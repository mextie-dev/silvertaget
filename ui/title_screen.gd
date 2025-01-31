extends Control

@onready var house_cam: Camera3D = $HouseBG/HouseCam
@onready var station_cam: Camera3D = $TrainBG/StationCam

@onready var ui_sound_hover: AudioStreamPlayer = $TitleScreenUI/UISoundHover
@onready var ui_sound_click: AudioStreamPlayer = $TitleScreenUI/UISoundClick


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
	ui_sound_click.play()
	get_tree().change_scene_to_file("res://ui/opening_cutscene.tscn")


func _on_options_pressed() -> void:
	ui_sound_click.play()
	$OptionsScreen.show()
	$TitleScreenUI.hide()


func _on_quit_pressed() -> void:
	ui_sound_click.play()
	get_tree().quit()


func _on_eng_lang_button_pressed() -> void:
	ui_sound_click.play()
	print("language switched to english")


func _on_sve_lang_button_pressed() -> void:
	ui_sound_click.play()
	print("language switched to swedish")
	# TODO: figure out how tf to translate the game


func _on_back_pressed() -> void:
	ui_sound_click.play()
	$OptionsScreen.hide()
	$TitleScreenUI.show()


func _on_play_mouse_entered() -> void:
	ui_sound_hover.play()


func _on_options_mouse_entered() -> void:
	ui_sound_hover.play()
	pass # Replace with function body.


func _on_quit_mouse_entered() -> void:
	ui_sound_hover.play()
	pass # Replace with function body.


func _on_eng_lang_button_mouse_entered() -> void:
	ui_sound_hover.play()
	pass # Replace with function body.


func _on_sve_lang_button_mouse_entered() -> void:
	ui_sound_hover.play()
	pass # Replace with function body.


func _on_back_mouse_entered() -> void:
	ui_sound_hover.play()
	pass # Replace with function body.
