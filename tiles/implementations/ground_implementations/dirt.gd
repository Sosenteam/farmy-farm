class_name Dirt extends Ground

var moisture_percent:float

# buffs
var nitrogen:float = 0
var phosphorus:float = 0
var potassium:float = 0 
var growth_rate_multiplier:float = 1
var yield_multiplier:float = 1
var water_loss_multiplier:float = 1

func tick() -> void:
	pass

func change_nutrients(n:float, p:float, k:float):
	nitrogen = clampf(nitrogen + n, 0, Tile.constants.nutrient_capacity)
	phosphorus = clampf(phosphorus + p, 0, Tile.constants.nutrient_capacity)
	potassium = clampf(potassium + k, 0, Tile.constants.nutrient_capacity)
