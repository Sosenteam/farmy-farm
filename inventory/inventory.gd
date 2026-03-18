extends Node

var inventory = {"crops": [], "seeds": [], "machines": [], "fertilizer": []}
var money:int = 0

signal on_inventory_changed

func ready():
	_update_inventory()
	
func _update_inventory():
	on_inventory_changed.emit()
	
func sell(crop_array:Array[Crop]):
	for crop in crop_array:
		print("selling crop for ",crop.sell_price)
		money+=crop.sell_price
