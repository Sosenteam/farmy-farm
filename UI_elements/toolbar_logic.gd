extends HBoxContainer

var ICON_SHEET = preload("res://assets/ui_elements.png")
var ITEM_PULLOUT_SCENE = preload("res://UI_elements/item_pullout.tscn")

var seed_pullout: Control
var machine_pullout: Control
var fertilizer_pullout: Control

var plant_butt: TextureButton
var machine_butt: TextureButton
var fertilizer_butt: TextureButton

var constants = preload("res://tiles/tiles_resource.tres")
var item_constants = preload("res://item_manager/item_resources.tres")

func _ready():
	# Clear any placeholders from the editor
	Global.current_tool = Global.Tool.NONE
	
	for child in get_children():
		child.queue_free()

	# add things to the tool bar
	_add_tool_button(Global.Tool.WATER, "Water")
	_add_tool_button(Global.Tool.TILL, "Till")
	_add_tool_button(Global.Tool.PLANT, "Plant")
	_add_tool_button(Global.Tool.INSPECT, "Inspect")
	_add_tool_button(Global.Tool.MACHINE, "Machine")
	_add_tool_button(Global.Tool.FERTILIZER, "Fertilizer")
	
	# Initialize pullouts
	seed_pullout = ITEM_PULLOUT_SCENE.instantiate()
	machine_pullout = ITEM_PULLOUT_SCENE.instantiate()
	fertilizer_pullout = ITEM_PULLOUT_SCENE.instantiate()
	
	get_parent().add_child.call_deferred(seed_pullout)
	get_parent().add_child.call_deferred(machine_pullout)
	get_parent().add_child.call_deferred(fertilizer_pullout)
	
	# Setup pullouts
	seed_pullout.setup("seeds", ["Carrot", "Corn", "Wheat", "Potato"], {"Carrot": constants.carrot_seed_price, "Corn": constants.corn_seed_price, "Wheat": constants.wheat_seed_price, "Potato": constants.potato_seed_price})
	seed_pullout.item_selected.connect(func(item): Global.selected_seed = item)
	
	machine_pullout.setup("machines", ["Sprinkler"], {"Sprinkler": item_constants.sprinkler_price})
	machine_pullout.item_selected.connect(func(item): Global.selected_machine = item)
	
	fertilizer_pullout.setup("fertilizer", ["Fish", "Bone", "Seaweed"], {"Fish": item_constants.fish_price, "Bone": item_constants.bone_price, "Seaweed": item_constants.seaweed_price})
	fertilizer_pullout.item_selected.connect(func(item): Global.selected_fertilizer = item)

	Global.on_tool_changed.connect(_update_selection_visuals)

func _add_tool_button(tool_type: Global.Tool, tool_name: String):
	var btn = TextureButton.new()
	btn.name = tool_name
	btn.tooltip_text = tool_name
	
	if tool_type == Global.Tool.PLANT:
		plant_butt = btn
	elif tool_type == Global.Tool.MACHINE:
		machine_butt = btn
	elif tool_type == Global.Tool.FERTILIZER:
		fertilizer_butt = btn
	
	# Atlas slicing (each icon is 20x20)
	var atlas = AtlasTexture.new()
	atlas.atlas = ICON_SHEET
	atlas.region = Rect2(tool_type%5 * 20, floor(tool_type/5)*20, 20, 20)
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
		
	btn.pressed.connect(func(): 
		if (Global.current_tool == tool_type):
			Global.current_tool = Global.Tool.NONE
		else:
			Global.current_tool = tool_type
		)
	
	add_child(btn)

func _update_selection_visuals(_tool: int):
	for i in get_child_count():
		var child = get_child(i)
		if i == Global.current_tool || Global.current_tool == Global.Tool.NONE:
			child.modulate = Color.WHITE
		else:
			child.modulate = Color(0.897, 0.897, 0.897, 0.453)
			
	# Update pullouts visibility
	seed_pullout.close()
	machine_pullout.close()
	fertilizer_pullout.close()
	
	if Global.current_tool == Global.Tool.PLANT and plant_butt:
		seed_pullout.global_position = plant_butt.global_position + Vector2(4, 10)
		seed_pullout.open()
	elif Global.current_tool == Global.Tool.MACHINE and machine_butt:
		machine_pullout.global_position = machine_butt.global_position + Vector2(4, 10)
		machine_pullout.open()
	elif Global.current_tool == Global.Tool.FERTILIZER and fertilizer_butt:
		fertilizer_pullout.global_position = fertilizer_butt.global_position + Vector2(4, 10)
		fertilizer_pullout.open()
