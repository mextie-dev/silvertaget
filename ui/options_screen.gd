extends Control

@onready var mouse_sens_slider: HSlider = $MouseSens/MouseSensSlider
@onready var audio_vol_slider: HSlider = $AudioVol/AudioVolSlider



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_sens_slider.value = Options.mouseSensitivity
	audio_vol_slider.value = Options.audioVolume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func setMouseSensitivity(newValue):
	Options.mouseSensitivity = newValue
	print("mouse sensitivity set to " + str(newValue))

func setAudioVolume(newValue):
	Options.audioVolume = newValue
	# TODO: set audio volume using this
	print("audiovolume set to " + str(newValue))
	

func _on_quit_button_pressed() -> void:
	$UISoundClick.play()
	get_tree().quit()


func _on_fullscreen_button_pressed() -> void:
	$UISoundClick.play()
	Options.setFullscreen()


func _on_fullscreen_button_mouse_entered() -> void:
	$UISoundHover.play()
	pass # Replace with function body.


func _on_quit_button_mouse_entered() -> void:
	$UISoundHover.play()
	pass # Replace with function body.


func _on_audio_vol_slider_mouse_entered() -> void:
	$UISoundHover.play()
	pass # Replace with function body.


func _on_mouse_sens_slider_mouse_entered() -> void:
	$UISoundHover.play()
	pass # Replace with function body.
