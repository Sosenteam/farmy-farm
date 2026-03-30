extends Control

signal slot_clicked(slot_node)

var item_data

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		slot_clicked.emit(self)
		#print(Global.selected_seed, item_data)
		#print("handled")
		get_viewport().set_input_as_handled()  # stops the event propagating further

func set_slot(item):
	item_data = item
	$Control/TextureRect.texture = item.image
	$Control/Label.text = str(item.quantity)
	$Control/TextureRect.tooltip_text = item.type

func set_selected(selected: bool):

	#print(Global.selected_seed, item_data)
	if Global.selected_seed == item_data:
		$Control/NinePatchRect.self_modulate = Color(0.771, 0.771, 0.771, 1.0) # Light blue tint (Selected)
	else:
		$Control/NinePatchRect.self_modulate = Color(1.0, 1.0, 1.0) # White (Normal)
