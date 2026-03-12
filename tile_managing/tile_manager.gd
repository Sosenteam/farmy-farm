extends Node2D

var tiles = preload("res://tile_managing/tiles.tres")
var constants = preload("res://tiles/tiles_resource.tres")

var map = tiles.map

@onready var ground_layer = $GroundLayer
@onready var dirt_layer = $DirtLayer
@onready var occupant_layer = $OccupantLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.on_tick.connect(on_tick)
	for i in tiles.cells:
		map.append(Tile.new([Dirt].pick_random(),[Corn,Wheat,Carrot].pick_random()))
		map[i].ground.change_nutrients(randf_range(0,200),randf_range(0,200),randf_range(0,200))
		#map.append(Tile.new(Dirt,Wheat))
		map[i].occupant.change_growth_stage.connect(on_change_growth_stage.bind(i)) # Bind growthstage changes to function

	render()

func on_tick():
	#for i in map.size():
		#map[i].tick()
	pass
	
## Renders tile array to tilemaps 
func render():
	#Renders GroundLayer
	for i in map.size():
		dirt_layer.set_cells_terrain_connect([tiles.index_to_vector(i)],0,1)
		if(map[i].ground is Dirt): # Changes Terrain to Dirt
			ground_layer.erase_cell(tiles.index_to_vector(i))	
		if(map[i].ground is TilledDirt): # Changes Terrain to Dirt
			ground_layer.set_cells_terrain_connect([tiles.index_to_vector(i)],0,0)

	#Renders OccupantLayer 
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var tilemap_pos = ground_layer.local_to_map(get_local_mouse_position())
		if(tiles.is_in(tilemap_pos)):
			if(map[tiles.vector_to_index(tilemap_pos)].ground is Dirt):
				map[tiles.vector_to_index(tilemap_pos)].ground = TilledDirt.new()
				render()
			#print(tiles.get_tile(tilemap_pos).occupant.get_script().get_global_name())

func on_change_growth_stage(crop,stage: int, index: int) -> void:
	print("Stage: ",stage,"  Index: ",index)
	var tiles_to_access
	match crop:
		"wheat":
			tiles_to_access = 0
		"carrot":
			tiles_to_access = 1
		"corn":
			tiles_to_access = 2
	occupant_layer.set_cell(tiles.index_to_vector(index),tiles_to_access,Vector2i(stage,0))
	
