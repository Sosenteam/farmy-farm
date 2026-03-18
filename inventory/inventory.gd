extends Node

var inventory = {"crops": [], "seeds": [], "machines": [], "fertilizer": []}
var money:int = 0

signal on_inventory_changed

func ready():
	_update_inventory()
	
func _update_inventory():
	on_inventory_changed.emit()
	
