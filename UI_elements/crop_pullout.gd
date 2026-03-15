extends Control

@onready var container = $ScaledControl/NinePatchRect/ScrollContainer/VBoxContainer
var slot_scene = preload("res://slot.tscn")

var selected_slot = null

func _ready() -> void:
	#$ScaledControl/NinePatchRect/ScrollContainer.get_v_scroll_bar().scale = Vector2(0.5,0.5)
	Global.on_inventory_changed.connect(_update_list)
	_update_list()

func _update_list() -> void:
	print(Global.inventory)
	if not is_instance_valid(container):
		return
		
	# Clear existing children (the old slots)
	for child in container.get_children():
		child.queue_free()
	
	selected_slot = null
	
	# Loop through the items in the Seeds array
	for item in Global.inventory.Seeds:
		# Create a new slot custom node
		var new_slot = slot_scene.instantiate()
		new_slot.set_slot(item)
		
		# Connect the click signal!
		new_slot.slot_clicked.connect(_on_slot_clicked)
		
		# Add it to the VBoxContainer so they form a vertical list
		container.add_child(new_slot)

func _on_slot_clicked(slot_node) -> void:
	# Deselect the previous one if it exists
	if selected_slot:
		selected_slot.set_selected(false)
		
	# Update to the newly clicked slot
	selected_slot = slot_node
	selected_slot.set_selected(true)
	
	Global.selected_seed = selected_slot.item_data
	print("Selected crop: ", Global.selected_seed)
	
func open():
	show()
	$AnimationPlayer.play("open_popup")
	
#some very rookie code here lol
func close():
	$AnimationPlayer.play("close_popup")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("Asd")
	if (anim_name == "close_popup"):
		
		hide()
