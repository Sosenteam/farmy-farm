class_name Corn extends Plant

func _init():
	crop_name = &"corn"
	growth_stages = Tile.constants.corn_grow_stages
	base_growth_rate = Tile.constants.corn_grow_speed
	#TODO: Add personalized nutrient uptakes for each type of plant

func tick() -> void:
	super()
