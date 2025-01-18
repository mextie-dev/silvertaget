extends Node

var items = []

func _process(delta: float) -> void:
	if items.is_empty():
		return
	else:
		print(items[0].itemName)
