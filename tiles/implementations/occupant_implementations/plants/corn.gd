class_name Corn extends Plant

func _init():
	crop_name = &"corn"
	growth_stages = Tile.constants.corn_grow_stages
	base_growth_rate = Tile.constants.corn_grow_speed
	
	n_per_yield = Tile.constants.corn_n_per_yield
	p_per_yield = Tile.constants.corn_p_per_yield
	k_per_yield = Tile.constants.corn_k_per_yield
	n_happy_amount = Tile.constants.corn_n_happy_amount
	p_happy_amount = Tile.constants.corn_p_happy_amount
	k_happy_amount = Tile.constants.corn_k_happy_amount

func tick() -> void:
	super()
