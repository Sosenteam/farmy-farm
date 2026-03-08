extends Node2D

var tiles = load("res://tile_managing/tiles.tres")
var map = tiles.map

@onready var ground_layer = $GroundLayer
@onready var occupant_layer = $OccupantLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.on_tick.connect(on_tick)
	for i in tiles.cells:
		map.append(Tile.new())
	render()

func on_tick():
	for tile in map:
		tile.tick()
	
## Renders tile array to tilemaps 
func render():
	#Renders GroundLayer
	for i in map.size():
		if(map[i].ground is Dirt): # Changes Terrain to Dirt
			ground_layer.set_cells_terrain_connect([tiles.index_to_vector(i)],0,0)
	#Renders OccupantLayer 
	
