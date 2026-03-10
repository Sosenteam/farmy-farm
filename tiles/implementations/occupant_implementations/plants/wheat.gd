class_name Wheat extends Plant

func _init():
	crop_name = &"wheat"
	growth_stages = Tile.constants.wheat_grow_stages
	base_growth_rate = Tile.constants.wheat_grow_speed
	#TODO: Add personalized nutrient uptakes for each type of plant

func tick() -> void:
	super()
