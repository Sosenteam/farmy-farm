extends Node

@onready var manager = $".."
@onready var tiles = manager.tiles
@onready var map = tiles.map
@onready var ground_layer = $"../GroundLayer"
@onready var dirt_layer = $"../DirtLayer"
@onready var occupant_layer = $"../OccupantLayer"

var mouse_pressed = false

func _unhandled_input(event: InputEvent) -> void:
	#HOTKEYS
	#if event.is_action_pressed("test_size_increase"):
		#manager.add_size(-1,0)
	#
	if event is InputEventMouseButton:
		if event.button_index == 1:
			mouse_pressed = event.pressed
	if event is InputEventMouseMotion:
		var tilemap_pos = ground_layer.local_to_map(manager.get_local_mouse_position())
		if(tiles.is_in(tilemap_pos)):
			var tile = map[tiles.vector_to_index(tilemap_pos)]
			Global.current_selected_tile = tile
	if (event is InputEventMouseMotion && mouse_pressed) || (event is InputEventMouseButton && event.button_index == 1 && event.pressed):
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
					plant(index)
				Global.Tool.MACHINE:
					place_machine(index)
				Global.Tool.FERTILIZER:
					fertilize(index)
					
					
				Global.Tool.NONE:
					if(tile.occupant is Plant && tile.occupant.harvestable):
						tile.occupant.harvest()



func till(index):
	if(map[index].ground is Dirt && !(map[index].ground is TilledDirt) && !map[index].occupant):
			map[index].ground = TilledDirt.new(map[index].ground)
			manager.render()
	if(map[index].ground is Dirt && map[index].occupant is Machine):
		map[index].occupant._pick_up()
		occupant_layer.erase_cell(tiles.index_to_vector(index))
		

func water(index):
	if(map[index].ground is TilledDirt):
		map[index].ground.change_water(1)
		manager.ground_tiles_to_update[tiles.index_to_vector(index)]=true
		ground_layer.notify_runtime_tile_data_update()
	
func plant(index):
	var seed = Global.selected_seed
	if seed == null:
		return

	if map[index].occupant == null && map[index].ground is TilledDirt:
		if seed.quantity > 0:
			map[index].set_occupant(seed.crop)
			seed.addQuantity(-1)
			map[index].occupant.change_growth_stage.connect(manager.on_change_growth_stage.bind(index))
			map[index].occupant.harvested.connect(manager.on_harvested.bind(index))
		elif Inventory.money >= seed.price:
			Inventory.money -= seed.price
			Inventory.on_cash_changed.emit()
			_ensure_in_inventory("seeds", seed)
			map[index].set_occupant(seed.crop)
			map[index].occupant.change_growth_stage.connect(manager.on_change_growth_stage.bind(index))
			map[index].occupant.harvested.connect(manager.on_harvested.bind(index))
			Inventory.on_inventory_changed.emit()
		
func place_machine(index):
	var item = Global.selected_machine
	if item == null:
		return
	
	if !(map[index].occupant) && map[index].ground is Dirt:
		var can_place = false
		if item.quantity > 0:
			can_place = true
			item.addQuantity(-1)
		elif Inventory.money >= item.price:
			Inventory.money -= item.price
			Inventory.on_cash_changed.emit()
			_ensure_in_inventory("machines", item)
			can_place = true
			Inventory.on_inventory_changed.emit()
			
		if can_place:
			if map[index].ground is TilledDirt:
				map[index].ground = Dirt.from_tilled_dirt(map[index].ground)
				manager.render()
				
			# Map item type to class
			var occupant_class = null
			if item.type.to_lower() == "sprinkler":
				occupant_class = Sprinkler
			
			if occupant_class:
				map[index].set_occupant(occupant_class)
				manager.place_machine(index)
				map[index].occupant.pick_up.connect(manager.on_pick_up_machine.bind(index))

func fertilize(index):
	var item = Global.selected_fertilizer
	if item == null:
		return
		
	if map[index].ground is Dirt:
		if item.quantity > 0:
			if map[index].ground.fertilize(item.fertilizer):
				item.addQuantity(-1)
		elif Inventory.money >= item.price:
			if map[index].ground.fertilize(item.fertilizer):
				Inventory.money -= item.price
				Inventory.on_cash_changed.emit()
				_ensure_in_inventory("fertilizer", item)
				Inventory.on_inventory_changed.emit()

func _ensure_in_inventory(category: String, item: Item):
	var cat = category.to_lower()
	if not Inventory.inventory.has(cat):
		Inventory.inventory[cat] = []
	
	for inv_item in Inventory.inventory[cat]:
		if inv_item.type.to_lower() == item.type.to_lower():
			return # Already in inventory
			
	Inventory.inventory[cat].append(item)
