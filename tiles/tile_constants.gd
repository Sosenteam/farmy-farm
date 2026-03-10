extends Resource

# 480 ticks ish per crop growth
@export var TEST:float = 10
const ticks_per_second:int = 16
const ticks_per_day:int = ticks_per_second * 90
@export var BASE_WATER_LOSS:float = 1.0/ticks_per_day
@export var BASE_GROWTH_RATE:float = 1.0/480.0 # 0.00208333333
#@export var BASE_NUTRIENT_UPTAKE:float = 0.25/ticks_per_day
@export var BASE_NUTRIENT_UPTAKE:float = 0
@export var BASE_YIELD_COUNT = 1

@export var nutrient_capacity:float = 200

@export_category("Crop Constants")

@export_group("Wheat")
@export var wheat_grow_speed = 0.01 # Make Randomised?
@export var wheat_grow_stages = [0,0.25,0.5,0.75,1]
@export var wheat_n_uptake = 1.20
@export var wheat_p_uptake = 0.52
@export var wheat_k_uptake = 0.38

@export_group("Carrot")
@export var carrot_grow_speed = 0.01 # Make Randomised?
@export var carrot_grow_stages = [0,0.3,0.6,1]
@export var carrot_n_uptake = 0.17
@export var carrot_p_uptake = 0.09
@export var carrot_k_uptake = 0.34

@export_group("Corn")
@export var corn_grow_speed = 0.01 # Make Randomised?
@export var corn_grow_stages = [0,0.25,0.5,0.75,1]
@export var corn_n_uptake = 0.90
@export var corn_p_uptake = 0.35
@export var corn_k_uptake = 0.27
