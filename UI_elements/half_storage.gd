extends Control

@onready var VBox = $VBoxContainer
@onready var ItemBox = preload("res://UI_elements/half_storage_item_box.tscn")
# Called when the node enters the scene tree for the first time.
var selected_slot
func _ready() -> void:
	Inventory.on_inventory_changed.connect(refresh_inventory)
	refresh_inventory()
	Global.open_ui.connect(func(ui): if (ui == "sell"): get_parent().show())

func refresh_inventory() -> void:
	for child in VBox.get_children():
		child.queue_free()
		
	selected_slot = null
	
	for category in Inventory.inventory.keys():
		var items = Inventory.inventory[category]
		
		var newThing = ItemBox.instantiate()
		VBox.add_child(newThing)
		newThing.init_me(category.capitalize(), items)
		
	var previously_selected_item = selected_slot.item_data if selected_slot else null
		
			
func _on_slot_clicked(slot_node) -> void:
	Global.selected_seed = null
	for child in selected_slot:
		child.set_selected(false)
	if selected_slot == slot_node:
		return
	if selected_slot:
		print("nto sames")
		selected_slot.set_selected(false)
	selected_slot = slot_node
	Global.selected_seed = selected_slot.item_data
	selected_slot.set_selected(true)
	
	
	print("Selected crop: ", Global.selected_seed)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
