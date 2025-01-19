extends Node2D

@onready var dialogue_display := $Dialogue
@onready var name_display := $NameBoxCenterer/DispName

@onready var player := get_tree().get_first_node_in_group("player")

func _ready() -> void:
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	dialogue_display.visible_characters = 0
	
	var charsInScene = get_tree().get_nodes_in_group("characters")
	
	# convert all references in itemsInScene array to the actual item parent, then connect interaction signal
	for char in len(charsInScene):
		charsInScene[char] = charsInScene[char].get_parent()
		charsInScene[char].triggerDialogue.connect(showDialogue)

# Called when the node enters the scene tree for the first time.
func showDialogue(charName : String, dialogue : PackedStringArray, textSound : AudioStream, currentLine : int, lastLine : int):
	show()
	print(lastLine)
	if currentLine >= lastLine:
		#print(currentLine)
		dialogue_display.text = dialogue[lastLine - 1]
		name_display.text = charName
		for i in len(dialogue[lastLine - 1]):
			dialogue_display.visible_characters += 1
			i += 1
			await get_tree().process_frame
			await get_tree().process_frame # literally just manually waiting 3 frames in a row for text
			await get_tree().process_frame
		
	else:
		dialogue_display.text = dialogue[currentLine]
		name_display.text = charName
		for i in len(dialogue[currentLine]):
			dialogue_display.visible_characters += 1
			i += 1
			await get_tree().process_frame
			await get_tree().process_frame # literally just manually waiting 3 frames in a row for text
			await get_tree().process_frame # im fucking stoopid
		




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(InputEvent):
	if Input.is_action_just_pressed("interact"):
		dialogue_display.visible_characters = 0
		
		hide()
		get_tree().paused = false
		await get_tree().process_frame
		player.isInDialogue = false
		pass