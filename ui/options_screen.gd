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
	get_tree().quit()


func _on_fullscreen_button_pressed() -> void:
	Options.setFullscreen()
