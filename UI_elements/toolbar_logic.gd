extends HBoxContainer

var ICON_SHEET = preload("res://assets/ui_elements.png")
var CROP_PULLOUT_SCENE = preload("res://UI_elements/crop_pullout.tscn")

var crop_pullout_instance: Control
var plant_butt: TextureButton

# Enum to match the 5 icons in the sheet (from left to right)
func _ready():
	# Clear any placeholders from the editor
	Global.current_tool = Global.Tool.NONE
	
	for child in get_children():
		child.queue_free()

	# add thingd to the tool bar
	_add_tool_button(Global.Tool.WATER, "Water")
	_add_tool_button(Global.Tool.TILL, "Till")
	_add_tool_button(Global.Tool.PLANT, "Plant")
	_add_tool_button(Global.Tool.INSPECT, "Inspect")
	
	# Instantiate and hide crop pullout
	crop_pullout_instance = CROP_PULLOUT_SCENE.instantiate()
	crop_pullout_instance.close()
	
	get_parent().add_child.call_deferred(crop_pullout_instance)

	#signal globally so the whole game and keep track? Lmk if you think otherwise
	Global.on_tool_changed.connect(_update_selection_visuals)

func _add_tool_button(tool_type: Global.Tool, tool_name: String):
	var btn = TextureButton.new()
	btn.name = tool_name
	btn.tooltip_text = tool_name
	
	if tool_type == Global.Tool.PLANT:
		plant_butt = btn
	
	# Atlas slicing (each icon is 20x20 in the 100x20 sheet)
	var atlas = AtlasTexture.new()
	atlas.atlas = ICON_SHEET
	atlas.region = Rect2(tool_type * 20, 0, 20, 20)
	btn.texture_normal = atlas
	
	btn.mouse_entered.connect(func():
		var tween = btn.create_tween()
		tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
		btn.pivot_offset = btn.size / 2
		tween.tween_property(btn, "scale", Vector2(1.15, 1.15), 0.15))

	btn.mouse_exited.connect(func():
		var tween = btn.create_tween()
		tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(btn, "scale", Vector2.ONE, 0.2))
		
	# Connect the signal
	btn.pressed.connect(func(): 
		if (Global.current_tool == tool_type):
			Global.current_tool = Global.Tool.NONE
		else:
			Global.current_tool = tool_type
		)
	
	add_child(btn)

#diming for not selected one
func _update_selection_visuals(_tool: int):
	for i in get_child_count():
		var child = get_child(i)
		if i == Global.current_tool || Global.current_tool == Global.Tool.NONE:
			child.modulate = Color.WHITE
		else:
			child.modulate = Color(0.897, 0.897, 0.897, 0.453)
			
	# Update crop pullout
	if crop_pullout_instance and plant_butt:
		if Global.current_tool == Global.Tool.PLANT:
			crop_pullout_instance.open()
			crop_pullout_instance.global_position = plant_butt.global_position + Vector2(-1, -55)
		else:
			crop_pullout_instance.close()

#func _process(delta: float) -> void:
	
