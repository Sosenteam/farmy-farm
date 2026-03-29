extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.open_ui.connect(func(ui): if (ui == "shop"): show())
	
	var exit_btn = %CloseButton
	if exit_btn:
		exit_btn.mouse_entered.connect(func(): exit_btn.self_modulate = Color(0.6, 0.6, 0.6))
		exit_btn.mouse_exited.connect(func(): exit_btn.self_modulate = Color.WHITE)

func _on_close_button_pressed() -> void:
	hide()

func _on_up_pressed() -> void:
	if(Inventory.check_if_broke(-250)):
		if(Global.tiles.width > 8):
			Global.expand_size(-1,-1)
		else:
			Global.expand_size(1,1)
		
		Inventory.money -= 250
	Inventory.on_cash_changed.emit()

func _on_carrot_button_pressed() -> void:
	Inventory.buy("seeds", "Carrot", 20)

func _on_corn_button_pressed() -> void:
	Inventory.buy("seeds", "Corn", 35)

func _on_wheat_button_pressed() -> void:
	Inventory.buy("seeds", "Wheat", 30)

func _on_potato_button_pressed() -> void:
	Inventory.buy("seeds", "Potato", 25)
