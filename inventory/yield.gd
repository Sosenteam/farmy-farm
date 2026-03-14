class_name Yield 

var crop_name: StringName
var item_count: int

func _init(name:StringName,count:int) -> void:
	#print(Global.inventory)
	for crop in Global.inventory.Crops:
		#print(crop.name, name)
		if (crop.name.to_lower() == name.to_lower()):
			#print("addingQuantitiy")
			crop.addQuantity(count)
			return
	#print("addingItem")
	Global.inventory.Crops.append(Item.new(name, count))
	
	#print(Global.inventory)
