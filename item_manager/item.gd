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
	
static var constants = preload("res://item_manager/item_resources.tres")
