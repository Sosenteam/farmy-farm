extends Control

@onready var container = $ScaledControl/Panel/ScrollContainer/FlowContainer/BoxContainer
var slot_scene = preload("res://inventory/slot.tscn")
var is_plant_opened = false
var selected_slot = null

func _ready() -> void:
	#$ScaledControl/NinePatchRect/ScrollContainer.get_v_scroll_bar().scale = Vector2(0.5,0.5)
	Global.on_inventory_changed.connect(_update_list)
	_update_list()

func _update_list() -> void:
	var previously_selected_item = selected_slot.item_data if selected_slot else null
	
	for child in container.get_children():
		child.queue_free()
	
	selected_slot = null
	
	for item in Global.inventory.seeds:
		var new_slot = slot_scene.instantiate()
		new_slot.set_slot(item)
		new_slot.slot_clicked.connect(_on_slot_clicked)
		container.add_child(new_slot)
		
		# Re-select if this was the previously selected item
		if previously_selected_item and new_slot.item_data == previously_selected_item:
			selected_slot = new_slot
			new_slot.set_selected(true)

func _on_slot_clicked(slot_node) -> void:
	if selected_slot == slot_node:
		return
	
	if selected_slot:
		print("nto sames")
		selected_slot.set_selected(false)
	
	
	
	selected_slot = slot_node
	Global.selected_seed = selected_slot.item_data
	selected_slot.set_selected(true)
	
	
	print("Selected crop: ", Global.selected_seed)
	
func open():
	is_plant_opened = true
	show()
	$AnimationPlayer.play("open_popup")
	
#some very rookie code here lol
func close():
	is_plant_opened = false
	$AnimationPlayer.play_backwards("open_popup")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#print("Asd")
	if (anim_name == "open_popup" && !is_plant_opened):
		hide()
		

#func _process(delta: float) -> void:
	#print(Global.selected_seed)
