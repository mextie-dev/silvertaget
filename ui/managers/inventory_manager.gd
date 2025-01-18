extends Node2D

# text slots for items
@onready var slot_one: Label = $Slots/SlotContainer/SlotIconContainerOne/SlotOne
@onready var slot_two: Label = $Slots/SlotContainer/SlotIconContainerTwo/SlotTwo
@onready var slot_three: Label = $Slots/SlotContainer/SlotIconContainerThree/SlotThree         
@onready var slot_four: Label = $Slots/SlotContainer/SlotIconContainerFour/SlotFour
@onready var slot_five: Label = $Slots/SlotContainer/SlotIconContainerFive/SlotFive
@onready var slot_six: Label = $Slots/SlotContainer/SlotIconContainerSix/SlotSix

# icon slots for items
@onready var slot_one_icon: TextureRect = $Slots/SlotContainer/SlotIconContainerOne/SlotOneIcon
@onready var slot_two_icon: TextureRect = $Slots/SlotContainer/SlotIconContainerTwo/SlotTwoIcon
@onready var slot_three_icon: TextureRect = $Slots/SlotContainer/SlotIconContainerThree/SlotThreeIcon         
@onready var slot_four_icon: TextureRect = $Slots/SlotContainer/SlotIconContainerFour/SlotFourIcon
@onready var slot_five_icon: TextureRect = $Slots/SlotContainer/SlotIconContainerFive/SlotFiveIcon
@onready var slot_six_icon: TextureRect = $Slots/SlotContainer/SlotIconContainerSix/SlotSixIcon

var itemSlots = []
var itemIcons = []

func _ready() -> void:
	
	# get all items in the current scene and store them
	var itemsInScene = get_tree().get_nodes_in_group("items")
	
	# convert all references in itemsInScene array to the actual item parent, then connect interaction signal
	for item in len(itemsInScene):
		itemsInScene[item] = itemsInScene[item].get_parent()
		itemsInScene[item].interactedItem.connect(addItem)
		
	
	
	# initialize text for slots
	itemSlots = [slot_one, slot_two, slot_three, slot_four, slot_five, slot_six]
	
	# initialize icons for slots
	itemIcons = [slot_one_icon, slot_two_icon, slot_three_icon, slot_four_icon, slot_five_icon, slot_six_icon]
	
	# clear the inventory, set all item slot text and item icons to empty
	for slot in len(itemSlots):
		#print(itemSlots[slot])
		itemSlots[slot].text = " "
		itemIcons[slot].texture = null
		slot += 1
	
	# then initialize the inventory again based on the global items array,
	for slot in len(PlayerVariables.items):
		itemSlots[slot].text = PlayerVariables.items[slot].itemName
		itemIcons[slot].texture = PlayerVariables.items[slot].icon
		
	#print(itemSlots)

func _process(delta: float) -> void:
	#print(PlayerVariables.items)
	pass


## clear the player inventory, only called in special circumstances or for testing
func clearInventory():
	PlayerVariables.items.clear()
	print("erased yuh shit lilbro")
	for slot in len(itemSlots):
		#print(itemSlots[slot])
		itemSlots[slot].text = " "
		slot += 1

## adds an item to the players displayed inventory and stores it to be persistent across scenes
func addItem(stats):
	
	# if the players inventory is full, do nothing
	if len(PlayerVariables.items) == 6:
		print("fucky wucky inventory full")
		return
		
	# add the item to the global items array so it can be reestablished across scenes
	PlayerVariables.items.append(stats)
	
	# loops over the item slots until it finds an empty slot (indicated by " "), then sets that slot to contain the text
	# and icon for the item to be added. failsafes for if the inventory is full
	var currentSlot = 0
	for slot in len(itemSlots):
		if itemSlots[slot].text != " ":
			currentSlot += 1
			slot += 1
		elif currentSlot > 5:
			break
		else:
			currentSlot = slot
			break
	if currentSlot > 5:
		print("if this prints you should kill yourself")
	else:
		itemSlots[currentSlot].text = (
			str(stats.itemName)
		)
		itemIcons[currentSlot].texture = (
			stats.icon
		)
	#print("current inv" + str(items))
	pass


## removes an item from the displayed inventory and the global items array
func removeItem(stats):
	
	# remove from the items array
	PlayerVariables.items.erase(stats)
	
	# search through inventory until it finds the item to be destroyed, then sets its slot to empty
	for slot in len(itemSlots):
		if itemSlots[slot].text == stats.itemName:
			itemSlots[slot].text = " "
			itemIcons[slot].texture = null
			
			# goes through each item slot and moves the item slots up so the displayed inventory appears correctly
			# stops when it reaches the end of the current lenght of the items array
			for i in len(itemSlots):
				if i == len(PlayerVariables.items):
					break
				elif itemSlots[i].text == " ":
					itemSlots[i].text = itemSlots[i+1].text
					itemIcons[i].texture = itemIcons[i+1].texture
					itemSlots[i+1].text = " "
					itemIcons[i+1].texture = null
					
					i += 1
		else:
			slot += 1
