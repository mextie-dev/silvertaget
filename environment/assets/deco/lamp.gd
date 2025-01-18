extends Node3D

@onready var lamp_bulb: OmniLight3D = $LampBulb

@export var color : Color

@export var range := 3.0

@export var power := 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# sets lamp color range and energy to instance values
	lamp_bulb.light_color = color
	lamp_bulb.omni_range = range
	lamp_bulb.light_energy = power


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
