extends Node

@onready var sprite := $Sprite3D
@onready var headpoint := $HeadPoint

@onready var hitbox: StaticBody3D = $Hitbox


@onready var player := get_tree().get_first_node_in_group("player")

@export var stats : CharacterDialogue

signal triggerDialogue(displayname, dialogue, dialogue_sound, talkedtoamount, lastline)

var talkedTo := 0




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	player.interactedWithChar.connect(passChar)

	
	sprite.texture = stats.texture
	headpoint.position.y = stats.head_height
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func passChar(character) -> void:
	if hitbox == character:
		triggerDialogue.emit(stats.disp_name, stats.dialogue, stats.dialogue_sound, talkedTo, stats.lastLine)
		talkedTo += 1
		pass # Replace with function body.
