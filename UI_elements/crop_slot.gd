extends Control

signal slot_clicked(slot_node)

var item_data: Seed
var seed_type: String
var price: int = 5 

@onready var icon: TextureRect = %Icon
@onready var label: Label = %Label

func _ready() -> void:
	gui_input.connect(_on_gui_input)
	selected_effect(false)

func setup(_seed_type: String):
	seed_type = _seed_type
	# Find seed in inventory
	item_data = null
	for s in Inventory.inventory.seeds:
		if s.type.to_lower() == seed_type.to_lower():
			item_data = s
			break
	
	if item_data:
		icon.texture = item_data.image
		update_display()
	else:
		# If not in inventory, we need to get its name/image from Seed.new temporarily?
		# Actually, Seed.new(type, 0) could work to get the data
		var temp_seed = Seed.new(seed_type, 0)
		icon.texture = temp_seed.image
		update_display()

func update_display():
	if not item_data:
		for s in Inventory.inventory.seeds:
			if s.type.to_lower() == seed_type.to_lower():
				item_data = s
				icon.texture = item_data.image
				break
	
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
			# Buy seed
			Inventory.money -= price
			if item_data:
				item_data.addQuantity(1)
			else:
				var new_seed = Seed.new(seed_type, 1)
				Inventory.inventory.seeds.append(new_seed)
				item_data = new_seed
				Inventory.on_inventory_changed.emit()
		
		get_viewport().set_input_as_handled()

func selected_effect(active: bool):
	if active:
		modulate = Color(1.2, 1.2, 1.2, 1.0)
	else:
		modulate = Color.WHITE
