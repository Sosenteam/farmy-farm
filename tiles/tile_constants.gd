extends Resource

# 480 ticks ish per crop growth
@export var TEST:float = 10
const ticks_per_second:int = 16
const ticks_per_day:int = ticks_per_second * 90
@export var BASE_WATER_LOSS_PER_TICK:float = 1.0/ticks_per_day
@export var BASE_GROWTH_RATE:float = 1.0/480.0 # 0.00208333333
@export var BASE_NUTRIENT_PER_YIELD:float = 0
@export var BASE_NUTRIENT_HAPPY_AMOUNT:float = 0
@export var BASE_YIELD_COUNT = 1

@export var nutrient_capacity:float = 100

@export_category("Crop Constants")

@export_group("Wheat")
@export var wheat_grow_speed = 0.01 # NEED TO CHANGE - SHOULD BE BASED ON NPK AMNTS
@export var wheat_grow_stages = [0,0.25,0.5,0.75,1]
@export var wheat_n_per_yield = 55
@export var wheat_p_per_yield = 10
@export var wheat_k_per_yield = 5
@export var wheat_n_happy_amount = 30
@export var wheat_p_happy_amount = 5
@export var wheat_k_happy_amount = 2

@export_group("Carrot")
@export var carrot_grow_speed = 0.01 # NEED TO CHANGE - SHOULD BE BASED ON NPK AMNTS
@export var carrot_grow_stages = [0,0.3,0.6,1]
@export var carrot_n_per_yield = 10
@export var carrot_p_per_yield = 40
@export var carrot_k_per_yield = 10
@export var carrot_n_happy_amount = 5
@export var carrot_p_happy_amount = 25
@export var carrot_k_happy_amount = 5

@export_group("Corn")
@export var corn_grow_speed = 0.01 # NEED TO CHANGE - SHOULD BE BASED ON NPK AMNTS
@export var corn_grow_stages = [0,0.16,0.33,0.5,0.66,0.83,1]
@export var corn_n_per_yield = 20
@export var corn_p_per_yield = 0
@export var corn_k_per_yield = 30
@export var corn_n_happy_amount = 10
@export var corn_p_happy_amount = 1
@export var corn_k_happy_amount = 13
