extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible_characters = 0
	for i in len(text):
		visible_characters += 1
		i += 1
		await get_tree().process_frame
		await get_tree().process_frame # literally just manually waiting 3 frames in a row for text
		await get_tree().process_frame # im fucking stoopid


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
