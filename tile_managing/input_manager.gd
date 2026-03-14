extends Node

@onready var manager = $".."
@onready var tiles = manager.tiles
@onready var map = tiles.map
@onready var ground_layer = $"../GroundLayer"
@onready var dirt_layer = $"../DirtLayer"
@onready var occupant_layer = $"../OccupantLayer"

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# Get tile where mouse pressed
		var tilemap_pos = ground_layer.local_to_map(manager.get_local_mouse_position())
		var index = tiles.vector_to_index(tilemap_pos)
		
		
		# Check if tile exists in tiles
		if(tiles.is_in(tilemap_pos)):
			var tile = map[tiles.vector_to_index(tilemap_pos)]
			match Global.current_tool:
				Global.Tool.TILL:
					till(index)
				Global.Tool.WATER:
					water(index)
				Global.Tool.INSPECT:
					Global.current_selected_tile = tile
					#print(tiles.get_tile(tilemap_pos).occupant.get_script().get_global_name())
					
			if(tile.occupant != null && tile.occupant.growth_stages.size()-1 == tile.occupant.current_growth_stage):
				print("HEREASD")
				Yield.new(tile.occupant.crop_name,tile.occupant.yield_count)
					#print(tiles.get_surrounding_tiles(tiles.vector_to_index(tilemap_pos)))



func till(index):
	if(map[index].ground is Dirt):
			map[index].ground = TilledDirt.new(map[index].ground)
			manager.render()

func water(index):
	if(map[index].ground is TilledDirt):
		map[index].ground.moisture_percent = 1
