extends CanvasLayer

@onready var n = $Control2/VBoxContainer/HBoxContainer/Control/N
@onready var k = $Control2/VBoxContainer/HBoxContainer4/Control/K
@onready var p = $Control2/VBoxContainer/HBoxContainer2/Control/P
@onready var w = $Control2/VBoxContainer/HBoxContainer3/Control/Water
@onready var growth_progess_bar = $Control2/NinePatchRect/TextureProgressBar
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.on_tool_changed.connect(toggle)
	hide()

func toggle(tool):
	if(tool == 3):
		if (visible):
			hide()
		else:
			show()
	else:
		hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
# This could probably be called every tick instead of every frame?
func _process(delta: float) -> void:
	if (Global.current_selected_tile):
		if Global.current_selected_tile.occupant && "n_happy_amount" in Global.current_selected_tile.occupant:
		
			n.get_parent_control().get_child(1).position.x = Global.current_selected_tile.occupant.n_happy_amount
			p.get_parent_control().get_child(1).position.x = Global.current_selected_tile.occupant.p_happy_amount
			k.get_parent_control().get_child(1).position.x = Global.current_selected_tile.occupant.k_happy_amount
		if Global.current_selected_tile.occupant && "growth_percentage" in Global.current_selected_tile.occupant:
			growth_progess_bar.value = Global.current_selected_tile.occupant.growth_percentage
		n.value = Global.current_selected_tile.ground.nitrogen
		p.value = Global.current_selected_tile.ground.phosphorus
		k.value = Global.current_selected_tile.ground.potassium
		w.value = Global.current_selected_tile.ground.moisture_percent * 100
	
