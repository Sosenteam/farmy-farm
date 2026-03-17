extends TileMapLayer
@onready var manager = $".."
@onready var tiles = $"..".tiles 
@onready var map = tiles.map

func _ready() -> void:
	#Global.on_tick.connect(on_tick)
	pass

func _use_tile_data_runtime_update(vector:Vector2i) -> bool:
	return manager.ground_tiles_to_update.get(vector,false)
	manager.ground_tiles_to_update = {}
func _tile_data_runtime_update(vect,tile_data):
	var tile = map[tiles.vector_to_index(vect)]
	var c = remap(tile.ground.moisture_percent,0,1,0,0.25)
	var modulate_color = Color(1-c,1-c,1-c,1)
	tile_data.modulate = modulate_color
	return tile_data

#func on_tick():
	##notify_runtime_tile_data_update()
	#
