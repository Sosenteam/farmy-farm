extends Node

var inventory = {"crops": [], "seeds": [], "machines": [], "fertilizer": []}
var money:int = 10000
var quota = {
	"crop":null,
	"amount":0,
	"time_left":1920,
	"max_time":1920,
	"possible_crops":[&"carrot",&"wheat",&"corn"],
	"min_amount":1,
	"max_amount":8,
	"time_left_percent":1.0
}
signal on_inventory_changed
signal on_cash_changed
signal sell_items(items)
signal send_off_truck(times)
signal update_truck_boxes(items)
signal on_quota_changed

func _ready():
	_update_inventory()
	Global.on_tick.connect(on_tick)
	create_quota()

func on_tick():
	quota.time_left -=1
	quota.time_left_percent = float(quota.time_left)/float(quota.max_time)
	on_quota_changed.emit()
	if(quota.time_left<0):
		fail_quota()
func _update_inventory():
	on_inventory_changed.emit()
	
func sell(crop_array:Array[Crop]):
	
	for crop in crop_array:
		
		print("selling crop for ",crop.sell_price)
		if(crop.crop_str.to_lower() == quota.crop):
			quota.amount-=crop.quantity
			print("subtracing one ",crop.crop_str," from the quota")
			if(quota.amount<1):
				win_quota()
		money+=crop.sell_price*crop.quantity
	_update_inventory()
	on_cash_changed.emit()
	send_off_truck.emit(crop_array)
	
func buy(item):
	on_cash_changed.emit()

func create_quota():
	quota.crop = quota.possible_crops.pick_random()
	quota.amount = randi_range(quota.min_amount,quota.max_amount)
	quota.time_left = quota.max_time
	print("new quota of ",quota.amount," of ",quota.crop,"with time ",quota.time_left)

func fail_quota():
	print("you suck")
	create_quota()

func win_quota():
	print("you are awesome")
	create_quota()

func edit_bal(num:int):
	if(money+num > -1):
		money += num
