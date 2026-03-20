class_name Dirt extends Ground

var moisture_percent:float

# buffs
var nitrogen:float = 50
var phosphorus:float = 50
var potassium:float = 50
var growth_rate_multiplier:float = 1
var yield_multiplier:float = 1
var water_loss_multiplier:float = 1

static func from_tilled_dirt(dirt: TilledDirt) -> Dirt:
	var new_dirt = Dirt.new()
	
	for p in dirt.get_property_list():
		if p.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			new_dirt.set(p.name, dirt.get(p.name))
	
	return new_dirt

func tick() -> void:
	moisture_percent = clampf(moisture_percent - (Tile.constants.BASE_WATER_LOSS_PER_TICK * water_loss_multiplier), 0.0, 1.0)
	
func change_water(water:float) -> void:
	if water < 0:
		water *= water_loss_multiplier
	moisture_percent = clampf(moisture_percent + water, 0.0, 1.0)

func change_nutrients(n:float, p:float, k:float):
	nitrogen = clampf(nitrogen + n, 0, Tile.constants.nutrient_capacity)
	phosphorus = clampf(phosphorus + p, 0, Tile.constants.nutrient_capacity)
	potassium = clampf(potassium + k, 0, Tile.constants.nutrient_capacity)

func fertilize(fert:Fertilizer) -> bool:
	var n = fert.n_to_add
	var p = fert.p_to_add
	var k = fert.k_to_add
	# This stops fertilizer use if ANY nutrient would be over 100 (maybe change it to if all)
	if(nitrogen+n >Tile.constants.nutrient_capacity):
		return false
	if(phosphorus+p >Tile.constants.nutrient_capacity):
		return false
	if(potassium+k >Tile.constants.nutrient_capacity):
		return false
	nitrogen = clampf(nitrogen + n, 0, Tile.constants.nutrient_capacity)
	phosphorus = clampf(phosphorus + p, 0, Tile.constants.nutrient_capacity)
	potassium = clampf(potassium + k, 0, Tile.constants.nutrient_capacity)
	
	return true
