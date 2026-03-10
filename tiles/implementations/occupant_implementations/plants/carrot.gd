class_name Carrot extends Plant

func _init():
	crop_name = &"carrot"
	growth_stages = Tile.constants.carrot_grow_stages
	base_growth_rate = Tile.constants.carrot_grow_speed
	#TODO: Add personalized nutrient uptakes for each type of plant

func tick() -> void:
	super()
