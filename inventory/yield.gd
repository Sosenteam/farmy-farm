class_name Yield 

var crop_name: StringName
var item_count: int

func _init(name:StringName,count:int) -> void:
	for crop in Global.inventory.Crops:
		if (crop.name.to_lower() == name.to_lower()):
			crop.addQuantity(count)
			return
	Global.inventory.Crops.append(Item.new(name, count))
