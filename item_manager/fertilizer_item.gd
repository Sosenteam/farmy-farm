class_name FertilizerItem extends Item

var fertilizer
var sell_price

func _init(fertilizer_type: String, _quantity: int = 1) -> void:
	fertilizer = fertilizer_type
	quantity = _quantity
	
	var prefix = fertilizer_type.to_lower()
	image = constants.get(prefix + "_image")
	name = constants.get(prefix + "_name")
	sell_price = tile_constants.get(prefix + "_sell_price")
