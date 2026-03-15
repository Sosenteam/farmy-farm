extends Node

@onready var manager = $".."
@onready var tiles = manager.tiles
@onready var map = tiles.map
@onready var ground_layer = $"../GroundLayer"
@onready var dirt_layer = $"../DirtLayer"
@onready var occupant_layer = $"../OccupantLayer"

var mouse_pressed = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			mouse_pressed = event.pressed
	if event is InputEventMouseMotion && mouse_pressed:
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
				Global.Tool.PLANT:
					# CHANGE THIS TO A REAL MENU
					plant(index)
					
				Global.Tool.NONE:
					if(tile.occupant is Plant && tile.occupant.harvestable):
						tile.occupant.harvest()



func till(index):
	if(map[index].ground is Dirt):
			map[index].ground = TilledDirt.new(map[index].ground)
			manager.render()

func water(index):
	if(map[index].ground is TilledDirt):
		map[index].ground.moisture_percent = 1

func plant(index):
	var seed = Global.selected_seed
	if seed == null:
		print("No crop selected from menu!")
		return

	if(map[index].occupant == null && seed.quantity > 0):
		map[index].set_occupant(seed.crop)
		seed.addQuantity(-1)
		map[index].occupant.change_growth_stage.connect(manager.on_change_growth_stage.bind(index))
		map[index].occupant.harvested.connect(manager.on_harvested.bind(index))
