class_name Wheat extends Plant

func _init():
	crop_name = &"wheat"
	growth_stages = Tile.constants.wheat_grow_stages
	base_growth_rate = Tile.constants.wheat_grow_speed
	
	n_per_yield = Tile.constants.wheat_n_per_yield
	p_per_yield = Tile.constants.wheat_p_per_yield
	k_per_yield = Tile.constants.wheat_k_per_yield
	n_happy_amount = Tile.constants.wheat_n_happy_amount
	p_happy_amount = Tile.constants.wheat_p_happy_amount
	k_happy_amount = Tile.constants.wheat_k_happy_amount

func tick() -> void:
	super()
