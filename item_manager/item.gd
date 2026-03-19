class_name Item

var image: Texture2D
var name: String
var type: String
var quantity: int



func _init(_type: String, _quantity: int = 1) -> void:
	type = _type
	quantity = _quantity
	
	var prefix = type.to_lower()
	image = constants.get(prefix + "_image")
	name = constants.get(prefix + "_name")
	
func addQuantity(count):
	quantity += count
	Inventory.on_inventory_changed.emit()
	if (quantity < 1 and not self is Seed):
		for array in Inventory.inventory.values():
			if self in array:
				array.erase(self)
	Inventory.on_inventory_changed.emit()
	
static var constants = preload("res://item_manager/item_resources.tres")
static var tile_constants = preload("res://tiles/tiles_resource.tres")
