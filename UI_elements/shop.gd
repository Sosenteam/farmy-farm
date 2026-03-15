extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.open_shop_ui.connect(func(): show())

func _on_close_button_pressed() -> void:
	hide()


func _on_button_pressed() -> void:
	var seed_name = ["Carrot","Corn","Wheat"].pick_random()
	
	for seed_item in Global.inventory.Seeds:
		if seed_item.type.to_lower() == seed_name.to_lower():
			seed_item.quantity += 1
			Global._update_inventory()
			return
			
			
	Global.inventory.Seeds.append(Seed.new(seed_name, 1))
	Global._update_inventory()
