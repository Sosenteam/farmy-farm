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
		# For now, create the Item for display (getting name and image from constants)
		if category_name == "seeds":
			item_data = Seed.new(item_type, 0)
		elif category_name == "fertilizer":
			item_data = FertilizerItem.new(item_type, 0)
		else:
			item_data = Item.new(item_type, 0)
	
	icon.texture = item_data.image
	
	update_display()

func _find_item_data():
	# Use lowercase keys for Inventory access as per inventory.gd
	var cat = category_name.to_lower()
	if Inventory.inventory.has(cat):
		for item in Inventory.inventory[cat]:
			if item.type.to_lower() == item_type.to_lower():
				item_data = item
				return

func update_display():
	if not icon: icon = get_node("%Icon")
	if not label: label = get_node("%Label")
	
	# Always try to find the actual item in inventory
	_find_item_data()
	
	if not item_data:
		return
	
	var qty = item_data.quantity
	
	if qty > 0:
		label.text = str(qty)
		label.add_theme_color_override("font_color", Color.BLACK)
	else:
		label.text = "$"
		var buy_price = item_data.price if item_data else price
		label.text = str(buy_price) + "$"
		if Inventory.money >= buy_price:
			label.add_theme_color_override("font_color", Color.GREEN)
		else:
			label.add_theme_color_override("font_color", Color.RED)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		slot_clicked.emit(self)
		get_viewport().set_input_as_handled()


func selected_effect(active: bool):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	if active:
		modulate = Color(1.5, 1.5, 1.5, 1.0)
		tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
		# Ensure we are drawn on top
		z_index = 1
	else:
		modulate = Color.WHITE
		tween.tween_property(self, "scale", Vector2.ONE, 0.1)
		z_index = 0


func _on_mouse_entered() -> void:
	Global.hovered_item = self


func _on_mouse_exited() -> void:
	Global.hovered_item = null
