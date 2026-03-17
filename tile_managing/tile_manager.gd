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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in tiles.cells:
		map.append(Tile.new([Dirt].pick_random(),null))
		map[i].index = i
	render()

## Renders tile array to tilemaps 
# THIS FUNCTION NEEDS OPTIMISATION
func render():
	#Renders GroundLayer
	
	
	for i in map.size():
		if !dirt_rendered:
			dirt_layer.set_cells_terrain_connect([tiles.index_to_vector(i)],0,1)
		if(map[i].ground is Dirt): # Changes Terrain to Dirt
			ground_layer.erase_cell(tiles.index_to_vector(i))	
		if(map[i].ground is TilledDirt): # Changes Terrain to Dirt
			ground_layer.set_cells_terrain_connect([tiles.index_to_vector(i)],0,0)
	dirt_rendered = true
	#Renders OccupantLayer 

func update_water():
	
	for i in range(tiles.width):
		ground_tiles_to_update[tiles.index_to_vector(i+current_water_render_row)]=true
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
	occupant_layer.set_cell(tiles.index_to_vector(index),tiles_to_access,Vector2i(stage,0))

func on_harvested(product:Yield,index:int):
	 #THIS SHOULD GET SENT TO INVENTORY??
	for crop in Global.inventory.Crops:
		if (crop.name.to_lower() == name.to_lower()):
			crop.addQuantity(product.item_count)
			return
	Global.inventory.Crops.append(Item.new(product.crop_name, product.item_count))

func add_size(x,y):
	tiles.add_size(-1,0)
	if(x<0):
		position.x+=x*16
	if(y<0):
		position.y+=y*16
	
	dirt_rendered = false
	render()
