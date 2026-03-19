class_name Plant extends Occupant

var crop_name:StringName = ""
var growth_percentage:float = 0.0;
var growth_stages:Array
var current_growth_stage:int = 0
var has_emitted_initial_stage:bool = false
var base_growth_rate:float = Tile.constants.BASE_GROWTH_RATE
var n_per_yield:float = Tile.constants.BASE_NUTRIENT_PER_YIELD
var p_per_yield:float = Tile.constants.BASE_NUTRIENT_PER_YIELD
var k_per_yield:float = Tile.constants.BASE_NUTRIENT_PER_YIELD
var n_happy_amount:float = Tile.constants.BASE_NUTRIENT_HAPPY_AMOUNT
var p_happy_amount:float = Tile.constants.BASE_NUTRIENT_HAPPY_AMOUNT
var k_happy_amount:float = Tile.constants.BASE_NUTRIENT_HAPPY_AMOUNT
var water_per_yield:float = Tile.constants.BASE_WATER_PER_YIELD
var water_requirement:float = Tile.constants.BASE_WATER_REQUIREMENT
var sell_price:int = 1
var harvestable:bool = false
var yield_count = Tile.constants.BASE_YIELD_COUNT

signal change_growth_stage(stage:int)
signal harvested(product:Yield)

func tick() -> void:
	if tile.ground is TilledDirt: # You never know
		var dirt_tile = tile.ground as TilledDirt
		
		# ==== First Stage Show ===== #
		if !has_emitted_initial_stage:
			has_emitted_initial_stage = true
			change_growth_stage.emit(crop_name, 0)
		 
		# ==== Grow ==== #
		var effectiveGrowthRate = \
			base_growth_rate * \
			get_nutrient_multiplier(dirt_tile.nitrogen, n_happy_amount) * \
			get_nutrient_multiplier(dirt_tile.phosphorus, p_happy_amount) * \
			get_nutrient_multiplier(dirt_tile.potassium, k_happy_amount) * \
			get_water_growthrate_multiplier(dirt_tile.moisture_percent) * \
			dirt_tile.growth_rate_multiplier
		
		growth_percentage += effectiveGrowthRate;
		#print(str(base_growth_rate) + " " + str(effectiveGrowthRate))
		
		if growth_stages.size() - 1 > current_growth_stage: # not at max
			if growth_percentage >= growth_stages[current_growth_stage + 1]:
				current_growth_stage += 1
				change_growth_stage.emit(crop_name, current_growth_stage)
		else:
			harvestable = true
			
		# ==== affect soil ==== #
		dirt_tile.change_water(-water_per_yield * effectiveGrowthRate);
		dirt_tile.change_nutrients(-n_per_yield * effectiveGrowthRate, -p_per_yield * effectiveGrowthRate, -k_per_yield * effectiveGrowthRate)
		

func get_nutrient_multiplier(soil_has:float, plant_wants:float):
	if soil_has < plant_wants:
		if soil_has < (0.5 * plant_wants):
			return 0.6
		else:
			return 0.8
	if (plant_wants == 0) or (soil_has / plant_wants < 20):
		return 1.0
	return 1.25
	
func get_water_growthrate_multiplier(soil_water_percent:float):
	if soil_water_percent < water_requirement:
		return 0.01
	return 1

func harvest() -> void:
	harvested.emit(Yield.new(crop_name,yield_count))
	change_growth_stage.emit(crop_name,-1)
	tile.delete_occupant()
