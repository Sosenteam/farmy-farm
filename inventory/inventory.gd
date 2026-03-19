extends Node

var inventory = {"crops": [], "seeds": [], "machines": [], "fertilizer": []}
var money:int = 0
var quota = {
	"crop":null,
	"amount":0,
	"time_left":1920,
	"max_time":1920,
	"possible_crops":[&"carrot",&"wheat",&"corn"],
	"min_amount":1,
	"max_amount":8,
}
signal on_inventory_changed
signal sell_items(items)
signal update_truck_boxes(items)

func _ready():
	_update_inventory()
	Global.on_tick.connect(on_tick)

func on_tick():
	quota.time_left -=1
	if(quota.time_left<0):
		fail_quota()
func _update_inventory():
	on_inventory_changed.emit()
	
func sell(crop_array:Array[Crop]):
	for crop in crop_array:
		print("selling crop for ",crop.sell_price)
		if(crop.crop == quota.crop):
			quota.amount-=1
			if(quota.amount<1):
				win_quota()
		money+=crop.sell_price
	_update_inventory()

func create_quota():
	quota.crop = quota.possible_crops.pick_random()
	quota.amount = randi_range(quota.min_amount,quota.max_amount)
	quota.time = quota.max_time

func fail_quota():
	print("you suck")

func win_quota():
	print("you are awesome")
	create_quota()
