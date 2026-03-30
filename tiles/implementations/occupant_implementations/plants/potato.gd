class_name Potato extends Plant

func _init():
	crop_name = &"potato"
	growth_stages = Tile.constants.potato_grow_stages
	base_growth_rate = Tile.constants.potato_grow_speed
	
	n_per_yield = Tile.constants.potato_n_per_yield
	p_per_yield = Tile.constants.potato_p_per_yield
	k_per_yield = Tile.constants.potato_k_per_yield
	n_happy_amount = Tile.constants.potato_n_happy_amount
	p_happy_amount = Tile.constants.potato_p_happy_amount
	k_happy_amount = Tile.constants.potato_k_happy_amount
	sell_price = Tile.constants.potato_sell_price
	water_per_yield = Tile.constants.potato_water_per_yield
func tick() -> void:
	super()
	
