class_name Item

var image: Texture2D
var name: String
var type: String
var quantity: int



func _init(_type: String, _quantity: int = 1) -> void:
	type = _type
	quantity = _quantity
	
	var prefix = type.to_lower()
	name = constants.get(prefix + "_name")
	
	var coords = constants.get(prefix + "_coords")
	if coords is Vector2i:
		var atlas = AtlasTexture.new()
		atlas.atlas = constants.ITEMS_SHEET
		atlas.region = Rect2(coords.x * 16, coords.y * 16, 16, 16)
		image = atlas
	else:
		image = constants.get(prefix + "_image")
	
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
