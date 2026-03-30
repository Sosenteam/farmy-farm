class_name FertilizerItem extends Item

var fertilizer: Fertilizer
var sell_price: int

func _init(fertilizer_type: String, _quantity: int = 1) -> void:
	super(fertilizer_type, _quantity)
	
	var prefix = fertilizer_type.to_lower()
	sell_price = Item.constants.get(prefix + "_price")
	
	match prefix:
		"fish": fertilizer = FishEmulsion.new()
		"bone": fertilizer = BoneMeal.new()
		"seaweed": fertilizer = SeaweedMeal.new()
