extends Node

signal on_tick
signal on_tool_changed(tool_type: int)
signal on_inventory_changed
signal open_shop_ui

var tick: int = 0
var current_tool: int = 0: set = _set_tool
var current_selected_tile: Tile
var selected_seed: Seed
var inventory = {"Crops": [], "Seeds": [], "Machines": [], "Fertilizer": []}
enum Tool { WATER, TILL, PLANT, INSPECT, NONE }

@onready var tick_timer = $TickTimer
func ready():
	_update_inventory()

func _set_tool(new_tool: int) -> void:
	current_tool = new_tool
	on_tool_changed.emit(new_tool)
	
func _update_inventory():
	on_inventory_changed.emit()
	

func _on_tick() -> void:
	tick += 1
	on_tick.emit()
