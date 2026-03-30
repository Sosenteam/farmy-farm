extends Control

var items_to_sell: Array[Crop] = []
var selected_slot
@onready var invCont = $Control/Background3/ItemBox/ScrollContainer/HFlowContainer
@onready var sellCont = $Control/ItemBox/ScrollContainer/HFlowContainer
var slot_scene = preload("res://inventory/slot.tscn")



func _ready() -> void:
	Global.open_ui.connect(func(ui): if (ui == "sell"): get_parent().show())
	Inventory.on_inventory_changed.connect(_update_list)
	
	var exit_btn = %Exit
	if exit_btn:
		exit_btn.mouse_entered.connect(func(): exit_btn.self_modulate = Color(0.6, 0.6, 0.6))
		exit_btn.mouse_exited.connect(func(): exit_btn.self_modulate = Color.WHITE)
		
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
	var item = slot_node.item_data
	var in_inv = (slot_node.get_parent() == invCont)
	var from_list = Inventory.inventory.crops if in_inv else items_to_sell
	var to_list = items_to_sell if in_inv else Inventory.inventory.crops
	
	if Input.is_key_pressed(KEY_SHIFT) or item.quantity <= 1:
		# Move whole stack
		from_list.erase(item)
		_merge_into_list(to_list, item)
	else:
		# Move only one
		item.quantity -= 1
		var single_item = Crop.new(item.type, 1)
		_merge_into_list(to_list, single_item)
	
	Inventory.on_inventory_changed.emit()
	Inventory.update_truck_boxes.emit(items_to_sell)

func _merge_into_list(list: Array, item: Crop):
	for target in list:
		if target.type.to_lower() == item.type.to_lower():
			target.quantity += item.quantity
			return
	list.append(item)

func _on_exit_pressed() -> void:
	get_parent().hide()


func _on_send_off_pressed() -> void:
	#print(items_to_sell)
	Inventory.sell(items_to_sell)
	
	items_to_sell.clear()
	Inventory.update_truck_boxes.emit(items_to_sell)
	_update_list()
	get_parent().hide()
