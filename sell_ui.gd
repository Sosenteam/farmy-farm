extends Control

var items_to_sell: Array[Crop] = []
var selected_slot
@onready var invCont = $Control/Background3/ItemBox/ScrollContainer/HFlowContainer
@onready var sellCont = $Control/ItemBox/ScrollContainer/HFlowContainer
var slot_scene = preload("res://inventory/slot.tscn")



func _ready() -> void:
	Global.open_ui.connect(func(ui): if (ui == "sell"): get_parent().show())
	Inventory.on_inventory_changed.connect(_update_list)
	_update_list()

func _update_list() -> void:
	var previously_selected_item = selected_slot.item_data if selected_slot else null
	
	for child in invCont.get_children():
		child.queue_free()
	for child in sellCont.get_children():
		child.queue_free()
		
	
	selected_slot = null
	
	for item in Inventory.inventory.crops:
		var new_slot = slot_scene.instantiate()
		new_slot.set_slot(item)
		new_slot.slot_clicked.connect(_on_slot_clicked)
		invCont.add_child(new_slot)
	
	for item in items_to_sell:
		var new_slot = slot_scene.instantiate()
		new_slot.set_slot(item)
		new_slot.slot_clicked.connect(_on_slot_clicked)
		sellCont.add_child(new_slot)
		
		if previously_selected_item and new_slot.item_data == previously_selected_item:
			selected_slot = new_slot
			new_slot.set_selected(true)
			
func _on_slot_clicked(slot_node:Node) -> void:
	selected_slot = slot_node
	if slot_node.get_parent() == invCont:
		slot_node.reparent(sellCont)
		Inventory.inventory.crops.erase(slot_node.item_data)
		items_to_sell.append(slot_node.item_data)
	elif slot_node.get_parent() == sellCont:
		slot_node.reparent(invCont)
		items_to_sell.erase(slot_node.item_data)
		Inventory.inventory.crops.append(slot_node.item_data)
	
	Inventory.update_truck_boxes.emit(items_to_sell)
	
	
	print("Selected crop: ", Global.selected_seed)

func _on_exit_pressed() -> void:
	get_parent().hide()


func _on_send_off_pressed() -> void:
	#print(items_to_sell)
	Inventory.sell(items_to_sell)
	items_to_sell.clear()
	Inventory.update_truck_boxes.emit(items_to_sell)
	_update_list()
	get_parent().hide()
