extends Node

var inventory = {"crops": [], "seeds": [], "machines": [], "fertilizer": []}
var money:int = 250
var quota = {
	"crop":null,
	"amount":0,
	"time_left":3840,
	"max_time":3840,
	"possible_crops":[&"carrot",&"wheat",&"corn",&"potato"],
	"min_amount":1,
	"max_amount":8,
	"time_left_percent":1.0,
	"lives":3,
	"quotas_complete":0
	
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
	add_starting_crops()

func add_starting_crops():
	add_item("seeds","wheat",5)
	add_item("seeds","corn",5)
	add_item("seeds","carrot",5)
	add_item("seeds","potato",5)
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
	
func add_item(category: String, type_name: String, amount: int = 1):
	var cat = category.to_lower()
	if not inventory.has(cat):
		inventory[cat] = []
	
	# Try to find and merge
	for item in inventory[cat]:
		if item.type.to_lower() == type_name.to_lower():
			item.addQuantity(amount)
			return
	
	# Not found, add new
	var new_item
	if cat == "seeds":
		new_item = Seed.new(type_name, amount)
	elif cat == "fertilizer":
		new_item = FertilizerItem.new(type_name, amount)
	elif cat == "crops":
		new_item = Crop.new(type_name, amount)
	else:
		new_item = Item.new(type_name, amount)
	
	inventory[cat].append(new_item)
	_update_inventory()

func buy(category: String, type_name: String, price: int, amount: int = 1):
	if money >= price * amount:
		money -= price * amount
		add_item(category, type_name, amount)
		on_cash_changed.emit()
		return true
	return false

func create_quota():
	quota.crop = quota.possible_crops.pick_random()
	quota.amount = randi_range(quota.min_amount,quota.max_amount)
	manage_quota_time()
	quota.time_left = quota.max_time
	print("new quota of ",quota.amount," of ",quota.crop,"with time ",quota.time_left)

func super_fail_quota():
	money-=200
	if Global.has_method("fail_game"):
		Global.fail_game()

func fail_quota():
	quota.lives-=1
	if(quota.lives <= 0):
		super_fail_quota()
	create_quota()

func win_quota():
	money+=10
	quota.quotas_complete+=1
	quota.lives=3
	create_quota()

func manage_quota_time():
	match quota.quotas_complete:
		0 or 1:
			quota.max_time=3840
		2:
			quota.max_time=2280
		3 or 4:
			quota.max_time=1920
		_: 
			quota.max_time=1440
		

func check_if_broke(num:int):
	if(money+num > -1):
		return true
	else:
		return false
