extends Node2D

var tiles = preload("res://tile_managing/tiles.tres")
var constants = preload("res://tiles/tiles_resource.tres")

var map = tiles.map
var dirt_rendered = false
var ground_tiles_to_update: Dictionary[Vector2i,bool] = {}
var occupant_tiles_to_update: Dictionary[Vector2i,bool] = {}
var current_water_render_row = 0

@onready var ground_layer = $GroundLayer
@onready var dirt_layer = $DirtLayer
@onready var occupant_layer = $OccupantLayer

var machine_tiles_id = 999;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.tiles = tiles
	Global.on_tick.connect(on_tick)
	Global.add_size.connect(add_size)
	for i in tiles.cells:
		map.append(Tile.new([Dirt].pick_random(),null))
		map[i].index = i
	render()

func on_tick():
	if(Global.tick % 10 == 0):
		update_water()

## Renders tile array to tilemaps 
# THIS FUNCTION NEEDS OPTIMISATION
func render():
	#Renders GroundLayer
	for i in map.size():
		var v = tiles.index_to_vector(i)
		if !dirt_rendered:
			dirt_layer.set_cells_terrain_connect([v],0,1)
		if(map[i].ground is Dirt && ground_layer.get_cell_source_id(v) != -1): # Changes Terrain to Dirt
			ground_layer.erase_cell(v)
		if(map[i].ground is TilledDirt && ground_layer.get_cell_source_id(v) == -1): # Changes Terrain to Dirt
			ground_layer.set_cells_terrain_connect([v],0,0,false)
	dirt_rendered = true
	#Renders OccupantLayer 

func occupant_rerender():
	# This is super broken
	for i in map.size():
		if(occupant_layer.get_cell_source_id(tiles.index_to_vector(i)) != 999):
			occupant_layer.erase_cell(tiles.index_to_vector(i))
		if (map[i].occupant is Machine):
			if("position" in map[i].occupant.scene ):
				print("moving machinbe")
				map[i].occupant.scene.position = tiles.index_to_vector(i)*16
				map[i].occupant.scene.position+=Vector2(8,8)
		elif(map[i].occupant is Plant):
			on_change_growth_stage(map[i].occupant.crop_name,map[i].occupant.current_growth_stage,i)
		reconnect_signals()
		

func update_water():
	for i in map.size():
		ground_tiles_to_update[tiles.index_to_vector(i)]=true
	ground_layer.notify_runtime_tile_data_update()


	current_water_render_row+= 1
	if(current_water_render_row>tiles.width):
		current_water_render_row = 0


func on_change_growth_stage(crop,stage: int, index: int) -> void:
	#print("Stage: ",stage,"  Index: ",index)
	if (stage == -1):
		occupant_layer.erase_cell(tiles.index_to_vector(index))
	var tiles_to_access
	match crop:
		"wheat":
			tiles_to_access = 0
		"carrot":
			tiles_to_access = 1
		"corn":
			tiles_to_access = 2
		"potato":
			tiles_to_access = 3
	occupant_layer.set_cell(tiles.index_to_vector(index),tiles_to_access,Vector2i(stage,0))

func on_harvested(product:Yield,index:int):
	Inventory.add_item("crops", product.crop_name, product.item_count)

func add_size(x,y):
	tiles.add_size(x,y)
	if(x<0):
		position.x+=x*16
	if(y<0):
		position.y+=y*16
	
	dirt_rendered = false
	render()
	update_water()
	occupant_rerender()


func place_machine(index:int):
	var machine = map[index].occupant
	
	if machine is Machine:
		var scene_index:int = 0;
		match machine.machine_name:
			"sprinkler":
				scene_index = 1
		print(scene_index)
		
		occupant_layer.set_cell(tiles.index_to_vector(index), machine_tiles_id, Vector2i(0, 0), scene_index)

func on_pick_up_machine(machine_name:String, count:int, index:int):
	occupant_layer.erase_cell(tiles.index_to_vector(index))
	map[index].occupant.delete_occupant()
	map[index].delete_occupant()
	
	for machine in Inventory.inventory.machines:
		if (machine.name.to_lower() == machine_name.to_lower()):
			machine.addQuantity(count)
			return
	Inventory.inventory.machines.append(MachineItem.new(machine_name, count))
	Inventory._update_inventory()
	
func reconnect_signals():
	for i in map.size():
		if(map[i].occupant && map[i].occupant is Plant):
			map[i].occupant.change_growth_stage.disconnect(on_change_growth_stage.bind(i))
			map[i].occupant.harvested.disconnect(on_harvested.bind(i))
			map[i].occupant.change_growth_stage.connect(on_change_growth_stage.bind(i))
			map[i].occupant.harvested.connect(on_harvested.bind(i))
