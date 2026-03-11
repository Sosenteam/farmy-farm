class_name Carrot extends Plant

func _init():
	crop_name = &"carrot"
	growth_stages = Tile.constants.carrot_grow_stages
	base_growth_rate = Tile.constants.carrot_grow_speed
	
	n_per_yield = Tile.constants.carrot_n_per_yield
	p_per_yield = Tile.constants.carrot_p_per_yield
	k_per_yield = Tile.constants.carrot_k_per_yield
	n_happy_amount = Tile.constants.carrot_n_happy_amount
	p_happy_amount = Tile.constants.carrot_p_happy_amount
	k_happy_amount = Tile.constants.carrot_k_happy_amount

func tick() -> void:
	super()
	
