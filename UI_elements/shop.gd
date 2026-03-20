extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.open_ui.connect(func(ui): if (ui == "shop"): show())

func _on_close_button_pressed() -> void:
	hide()

func _on_up_pressed() -> void:
	Global.expand_size(0,-1)


func _on_down_pressed() -> void:
	Global.expand_size(0,1)


func _on_left_pressed() -> void:
	Global.expand_size(-1,0)


func _on_right_pressed() -> void:
	Global.expand_size(1,0)


func _on_carrot_button_pressed() -> void:
	var seed_name = "Carrot"
	for seed_item in Inventory.inventory.seeds:
		if seed_item.type.to_lower() == seed_name.to_lower():
			seed_item.quantity += 1
			Inventory._update_inventory()
			return
	Inventory.inventory.seeds.append(Seed.new(seed_name, 1))
	Inventory.money -= 20
	Inventory.on_cash_changed.emit()
	Inventory._update_inventory()


func _on_corn_button_pressed() -> void:
	var seed_name = "Corn"
	for seed_item in Inventory.inventory.seeds:
		if seed_item.type.to_lower() == seed_name.to_lower():
			seed_item.quantity += 1
			Inventory._update_inventory()
			return
	Inventory.inventory.seeds.append(Seed.new(seed_name, 1))
	Inventory.money -= 35
	Inventory.on_cash_changed.emit()
	Inventory._update_inventory()

##func _on_potato_button_pressed() -> void:
##	var seed_name = "Potato"
##	for seed_item in Inventory.inventory.seeds:
##		if seed_item.type.to_lower() == seed_name.to_lower():
##			seed_item.quantity += 1
##			Inventory._update_inventory()
##			return
##	Inventory.inventory.seeds.append(Seed.new(seed_name, 1))
##	Inventory.money -= 25
##	Inventory.on_cash_changed.emit()
##	Inventory._update_inventory()

func _on_wheat_button_pressed() -> void:
	var seed_name = "Wheat"
	for seed_item in Inventory.inventory.seeds:
		if seed_item.type.to_lower() == seed_name.to_lower():
			seed_item.quantity += 1
			Inventory._update_inventory()
			return
	Inventory.inventory.seeds.append(Seed.new(seed_name, 1))
	Inventory.money -= 30
	Inventory.on_cash_changed.emit()
	Inventory._update_inventory()
