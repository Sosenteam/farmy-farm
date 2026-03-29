extends Control

@onready var title = $Title
@onready var body = $Body
@onready var hold_timer = $HoldTimer
@onready var off_timer = $OffTimer
func _process(delta: float) -> void:
	if(Global.hovered_item != null):
		if(hold_timer.is_stopped()&&!visible):
			hold_timer.start()
			off_timer.stop()
	else:
		if(off_timer.is_stopped()&&visible):
			off_timer.start()
	# Make it render right
	if(visible&&Global.hovered_item):
		position = get_global_mouse_position() + Vector2(-314/2,-150)
		title.text = Global.hovered_item.item_data.name
		if(Global.hovered_item.item_data is FertilizerItem):
			var new_body:String 
			new_body+=str("N : ",Global.hovered_item.item_data.fertilizer.n_to_add,"\nP : ",Global.hovered_item.item_data.fertilizer.p_to_add,"\nK : ",Global.hovered_item.item_data.fertilizer.k_to_add)
			body.text = new_body
		elif(Global.hovered_item.item_data is Seed):
			var new_body:String
			new_body += str("Sell Price: $",Global.hovered_item.item_data.crop_sell_price)
			body.text = new_body
		else:
			body.text = ""
func _on_hold_timer_timeout() -> void:
	visible = true


func _on_off_timer_timeout() -> void:
	visible = false
