extends HBoxContainer

const ICON_SHEET = preload("res://assets/ui_elements.png")

# Enum to match the 5 icons in the sheet (from left to right)
enum Tool { WATER, TILL, PLANT, INSPECT, HARVEST }

func _ready():
	# Clear any placeholders from the editor
	for child in get_children():
		child.queue_free()

	# add thingd to the tool bar
	_add_tool_button(Tool.WATER, "Water")
	_add_tool_button(Tool.TILL, "Till")
	_add_tool_button(Tool.PLANT, "Plant")
	_add_tool_button(Tool.INSPECT, "Inspect")
	_add_tool_button(Tool.HARVEST, "Harvest")

	#signal globally so the whole game and keep track? Lmk if you think otherwise
	Global.on_tool_changed.connect(_update_selection_visuals)

func _add_tool_button(tool_type: Tool, tool_name: String):
	var btn = TextureButton.new()
	btn.name = tool_name
	btn.tooltip_text = tool_name
	
	# Atlas slicing (each icon is 20x20 in the 100x20 sheet)
	var atlas = AtlasTexture.new()
	atlas.atlas = ICON_SHEET
	atlas.region = Rect2(tool_type * 20, 0, 20, 20)
	btn.texture_normal = atlas
	
	# click mouse look
	btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
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
	btn.pressed.connect(func(): Global.current_tool = tool_type)
	
	add_child(btn)

#diming for not selected one
func _update_selection_visuals(_tool: int):
	for i in get_child_count():
		var child = get_child(i)
		if i == Global.current_tool:
			child.modulate = Color.WHITE
		else:
			child.modulate = Color(0.897, 0.897, 0.897, 0.453)
