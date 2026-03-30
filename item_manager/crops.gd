class_name Crop extends Item

var crop
var sell_price
var crop_str
func _init(_type: String, _quantity: int = 1) -> void:
	super(_type, _quantity)
	
	var prefix = type.to_lower()
	sell_price = tile_constants.get(prefix + "_sell_price")
	crop_str = constants.get(prefix + "_seed_plants")
	if crop_str:
		match crop_str.to_lower(): #kinda bad because not easily expandable, but oh well );
			"wheat": crop = Wheat
			"corn": crop = Corn
			"carrot": crop = Carrot
			"potato": crop = Potato
