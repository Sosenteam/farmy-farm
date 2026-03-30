extends Control

@onready var HBox = $HBoxContainer
@onready var ItemBox = preload("res://UI_elements/item_box.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.open_ui.connect(open)
	Inventory.on_inventory_changed.connect(refresh_inventory)
	
	var exit_btn = %CloseButton
	if exit_btn:
		exit_btn.mouse_entered.connect(func(): exit_btn.self_modulate = Color(0.6, 0.6, 0.6))
		exit_btn.mouse_exited.connect(func(): exit_btn.self_modulate = Color.WHITE)
		
	refresh_inventory()

func refresh_inventory():
	
	for child in HBox.get_children():
		child.queue_free()
	
	for category in Inventory.inventory.keys():
		var items = Inventory.inventory[category]
		var newThing = ItemBox.instantiate()
		HBox.add_child(newThing)
		newThing.init_me(category.capitalize(), items)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func open(ui):
	if (ui == "storage"): 
		get_parent().show()
	
func _on_close_button_pressed() -> void:
	get_parent().hide()
