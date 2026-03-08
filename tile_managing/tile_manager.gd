extends Node2D

var tiles = load("res://tile_managing/tiles.tres")
var map = tiles.map

@onready var ground_layer = $GroundLayer
@onready var occupant_layer = $OccupantLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.on_tick.connect(on_tick)
	for i in tiles.cells:
		map.append(Tile.new(Dirt,Wheat))
	render()

func on_tick():
	for i in map.size():
		map[i].tick()
		
	
## Renders tile array to tilemaps 
func render():
	#Renders GroundLayer
	for i in map.size():
		if(map[i].ground is Dirt): # Changes Terrain to Dirt
			ground_layer.set_cells_terrain_connect([tiles.index_to_vector(i)],0,0)
		map[i].occupant.change_growth_stage.connect(on_change_growth_stage.bind(i)) #not rendering

	#Renders OccupantLayer 
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var tilemap_pos = ground_layer.local_to_map(event.position)
		if(tiles.is_in(tilemap_pos)):
			print(tiles.get_tile(tilemap_pos).occupant.get_script().get_global_name())

func on_change_growth_stage(stage: int, index: int) -> void:
	print("Stage: ",stage,"  Index: ",index)
	occupant_layer.set_cell(tiles.index_to_vector(index),0,Vector2i(1+stage,0))
	
