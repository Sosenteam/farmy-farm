extends Control

signal slot_clicked(slot_node)

var item_data: Item
var item_type: String
var category_name: String
var price: int = 5 

@onready var icon: TextureRect = %Icon
@onready var label: Label = %Label

func _ready() -> void:
	gui_input.connect(_on_gui_input)
	selected_effect(false)

func setup(_item_type: String, _category: String, _price: int = 5):
	# Ensure nodes are available if setup is called before ready
	if not icon:
		icon = get_node("%Icon")
	if not label:
		label = get_node("%Label")
		
	item_type = _item_type
	category_name = _category
	price = _price
	
	# Find item in inventory
	_find_item_data()
	
	if not item_data:
		# For now, just use generic Item for display (getting name and image from constants)
		var temp_item
		if category_name == "seeds":
			temp_item = Seed.new(item_type, 0)
		else:
			temp_item = Item.new(item_type, 0)
		icon.texture = temp_item.image
	else:
		icon.texture = item_data.image
	
	update_display()

func _find_item_data():
	item_data = null
	# Use lowercase keys for Inventory access as per inventory.gd
	var cat = category_name.to_lower()
	if Inventory.inventory.has(cat):
		for item in Inventory.inventory[cat]:
			if item.type.to_lower() == item_type.to_lower():
				item_data = item
				break

func update_display():
	if not icon: icon = get_node("%Icon")
	if not label: label = get_node("%Label")
	
	if not item_data:
		_find_item_data()
		if item_data:
			icon.texture = item_data.image
	
	var qty = item_data.quantity if item_data else 0
	
	if qty > 0:
		label.text = str(qty)
		label.add_theme_color_override("font_color", Color.BLACK)
	else:
		label.text = "$"
		if Inventory.money >= price:
			label.add_theme_color_override("font_color", Color.GREEN)
		else:
			label.add_theme_color_override("font_color", Color.RED)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if item_data and item_data.quantity > 0:
			slot_clicked.emit(self)
		elif Inventory.money >= price:
			Inventory.money -= price
			if item_data:
				item_data.addQuantity(1)
			else:
				var new_item
				if category_name == "seeds":
					new_item = Seed.new(item_type, 1)
				else:
					new_item = Item.new(item_type, 1)
				
				var cat = category_name.to_lower()
				if not Inventory.inventory.has(cat):
					Inventory.inventory[cat] = []
				Inventory.inventory[cat].append(new_item)
				item_data = new_item
				Inventory.on_inventory_changed.emit()
			
			# Auto-select if it was zero
			if item_data.quantity == 1:
				slot_clicked.emit(self)
		
		get_viewport().set_input_as_handled()

func selected_effect(active: bool):
	if active:
		modulate = Color(1.2, 1.2, 1.2, 1.0)
	else:
		modulate = Color.WHITE
