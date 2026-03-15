class_name Seed extends Item

var crop

func _init(_type: String, _quantity: int = 1) -> void:
	type = _type
	quantity = _quantity
	
	var prefix = type.to_lower()
	image = constants.get(prefix + "_seed_image")
	name = constants.get(prefix + "_seed_name")
	var crop_str = constants.get(prefix + "_seed_plants")
	match crop_str.to_lower(): #kinda bad because not easily expandable, but oh well );
		"wheat": crop = Wheat
		"corn": crop = Corn
		"carrot": crop = Carrot
