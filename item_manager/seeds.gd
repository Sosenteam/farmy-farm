class_name Seed extends Item

var crop
var crop_sell_price
func _init(_type: String, _quantity: int = 1):
	super(_type, _quantity)
	
	var prefix = type.to_lower()
	name = constants.get(prefix + "_seed_name")
	price = constants.get(prefix + "_seed_price") if constants.get(prefix + "_seed_price") else 5
	
	var coords = constants.get(prefix + "_seed_coords")
	if coords is Vector2i:
		var atlas = AtlasTexture.new()
		atlas.atlas = constants.ITEMS_SHEET
		atlas.region = Rect2(coords.x * 16, coords.y * 16, 16, 16)
		image = atlas
	else:
		image = constants.get(prefix + "_seed_image")
	var crop_str = constants.get(prefix + "_seed_plants")
	match crop_str.to_lower(): #kinda bad because not easily expandable, but oh well );
		"wheat": crop = Wheat
		"corn": crop = Corn
		"carrot": crop = Carrot
		"potato": crop = Potato
	
	crop_sell_price = tile_constants.get(prefix+"_sell_price")
