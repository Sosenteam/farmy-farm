extends Control

@onready var VBox = $VBoxContainer
@onready var ItemBox = preload("res://UI_elements/half_storage_item_box.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventory.on_inventory_changed.connect(refresh_inventory)
	refresh_inventory()

func refresh_inventory():
	for child in VBox.get_children():
		child.queue_free()
	
	for category in Inventory.inventory.keys():
		var items = Inventory.inventory[category]
		
		var newThing = ItemBox.instantiate()
		VBox.add_child(newThing)
		newThing.init_me(category.capitalize(), items)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
