class_name Plant extends Occupant

var crop_name:StringName = ""
var growth_percentage:float = 0.0;
var growth_stages:Array
var current_growth_stage:int = 0
var base_growth_rate:float = Tile.constants.BASE_GROWTH_RATE
var n_per_yield:float = Tile.constants.BASE_NUTRIENT_PER_YIELD
var p_per_yield:float = Tile.constants.BASE_NUTRIENT_PER_YIELD
var k_per_yield:float = Tile.constants.BASE_NUTRIENT_PER_YIELD
var n_happy_amount:float = Tile.constants.BASE_NUTRIENT_HAPPY_AMOUNT
var p_happy_amount:float = Tile.constants.BASE_NUTRIENT_HAPPY_AMOUNT
var k_happy_amount:float = Tile.constants.BASE_NUTRIENT_HAPPY_AMOUNT
var harvestable:bool = false
var yield_count = Tile.constants.BASE_YIELD_COUNT

signal change_growth_stage(stage:int)

func tick() -> void:
	if tile.ground is TilledDirt: # You never know
		var dirt_tile = tile.ground as TilledDirt
		
		# ==== Grow ==== #
		var effectiveGrowthRate = \
			base_growth_rate * \
			_get_nutrient_multiplier(dirt_tile.nitrogen, n_happy_amount) * \
			_get_nutrient_multiplier(dirt_tile.phosphorus, p_happy_amount) * \
			_get_nutrient_multiplier(dirt_tile.potassium, k_happy_amount) * \
			dirt_tile.growth_rate_multiplier
		
		growth_percentage += effectiveGrowthRate;
		print(str(base_growth_rate) + " " + str(effectiveGrowthRate))
		
		if growth_stages.size() - 1 > current_growth_stage: # not at max
			if growth_percentage >= growth_stages[current_growth_stage + 1]:
				current_growth_stage += 1
				change_growth_stage.emit(crop_name, current_growth_stage)
				
		# ==== Nutrients ==== #
		dirt_tile.change_nutrients(-n_per_yield, -p_per_yield, -k_per_yield)
		

func _get_nutrient_multiplier(soil_has:float, plant_wants:float):
	if soil_has < plant_wants:
		return 0.6
	if (plant_wants == 0) or (soil_has / plant_wants < 20):
		return 1.0
	return 1.25

func harvest(plant_name,yield_count) -> Yield:
	return Yield.new(plant_name,yield_count)
	
