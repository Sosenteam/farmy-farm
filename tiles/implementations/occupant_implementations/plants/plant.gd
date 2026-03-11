class_name Plant extends Occupant

var crop_name:StringName = ""
var growth_percentage:float = 0.0;
var growth_stages:Array
var current_growth_stage:int = 0
var base_growth_rate:float = Tile.constants.BASE_GROWTH_RATE
var phosphorus_uptake:float = Tile.constants.BASE_NUTRIENT_UPTAKE
var potassium_uptake:float = Tile.constants.BASE_NUTRIENT_UPTAKE
var nitrogen_uptake:float = Tile.constants.BASE_NUTRIENT_UPTAKE
var harvestable:bool = false
var yield_count = Tile.constants.BASE_YIELD_COUNT

signal change_growth_stage(stage:int)

func tick() -> void:
	if tile.ground is TilledDirt: # You never know
		var dirt_tile = tile.ground as TilledDirt
		
		var effectiveGrowthRate = \
			base_growth_rate * \
			_get_nutrient_multiplier(dirt_tile.nitrogen, nitrogen_uptake) * \
			_get_nutrient_multiplier(dirt_tile.phosphorus, phosphorus_uptake) * \
			_get_nutrient_multiplier(dirt_tile.potassium, potassium_uptake) * \
			dirt_tile.growth_rate_multiplier
		
		growth_percentage += effectiveGrowthRate;
		#print(str(base_growth_rate) + " " + str(effectiveGrowthRate))
		
		if growth_stages.size() - 1 > current_growth_stage: # not at max
			if growth_percentage >= growth_stages[current_growth_stage + 1]:
				current_growth_stage += 1
				change_growth_stage.emit(crop_name, current_growth_stage)

func _get_nutrient_multiplier(soil_has:float, plant_wants:float):
	if soil_has < plant_wants:
		return 0.6
	if (plant_wants == 0) or (soil_has / plant_wants < 1.25):
		return 1.0
	return 1.25

func harvest(plant_name,yield_count) -> Yield:
	return Yield.new(plant_name,yield_count)
	
