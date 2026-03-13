extends TileMapLayer

@onready var tiles = $"..".tiles 
@onready var map = tiles.map

func _ready() -> void:
	Global.on_tick.connect(on_tick)
	print("reminder to make ground_layer.gd more performant")

func _use_tile_data_runtime_update(vector:Vector2i) -> bool:
	return true
	# THIS NEEDS TO BE NOT TRUE FOR PERFORMANCE, WE SHOULD ONLY UPDATE TILES WITH A RESONABLE CHANGE

func _tile_data_runtime_update(vect,tile_data):
	var tile = map[tiles.vector_to_index(vect)]
	var c = remap(tile.ground.moisture_percent,0,1,0,0.25)
	var modulate_color = Color(1-c,1-c,1-c,1)
	tile_data.modulate = modulate_color
	return tile_data

func on_tick():
	notify_runtime_tile_data_update()
	
