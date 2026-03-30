extends Node

signal on_tick
signal on_tool_changed(tool_type: int)
signal open_ui(ui_type)
signal add_size

var tick: int = 0
var current_tool: int = 0: set = _set_tool
var current_selected_tile: Tile
var hovered_item
var selected_seed: Seed
var selected_machine: Item #Change to MachineItem?
var selected_fertilizer: FertilizerItem
var tiles

enum Tool { WATER, TILL, PLANT, INSPECT, MACHINE, FERTILIZER, NONE }
var inventory = {"Crops": [], "Seeds": [], "Machines": [], "Fertilizer": []}

@onready var tick_timer = $TickTimer


func _set_tool(new_tool: int) -> void:
	current_tool = new_tool
	on_tool_changed.emit(new_tool)
	


func _on_tick() -> void:
	tick += 1
	on_tick.emit()
	
func expand_size(x,y):
	add_size.emit(x,y)
