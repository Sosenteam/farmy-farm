extends Resource

# 480 ticks ish per crop growth
@export var TEST:float = 10
const ticks_per_second:int = 16
const ticks_per_day:int = ticks_per_second * 60
@export var BASE_WATER_LOSS_PER_TICK:float = 0.75/ticks_per_day
@export var BASE_GROWTH_RATE:float = 1.0/480.0 # 0.00208333333
@export var BASE_NUTRIENT_PER_YIELD:float = 0
@export var BASE_NUTRIENT_HAPPY_AMOUNT:float = 0
@export var BASE_YIELD_COUNT = 1
@export var BASE_WATER_PER_YIELD:float = 1
@export var BASE_WATER_REQUIREMENT:float = 0.15

@export var nutrient_capacity:float = 100

@export_category("Crop Constants")

@export_group("Wheat")
@export var wheat_grow_speed = (1.0/900.0) # NEED TO CHANGE - SHOULD BE BASED ON NPK AMNTS
@export var wheat_grow_stages = [0,0.25,0.5,0.75,1]
@export var wheat_n_per_yield = 55
@export var wheat_p_per_yield = 10
@export var wheat_k_per_yield = 5
@export var wheat_n_happy_amount = 30
@export var wheat_p_happy_amount = 5
@export var wheat_k_happy_amount = 2
@export var wheat_sell_price = 72
@export var wheat_seed_price = 30
@export var wheat_water_per_yield := 1

@export_group("Carrot")
@export var carrot_grow_speed = (1.0/510.0) # NEED TO CHANGE - SHOULD BE BASED ON NPK AMNTS
@export var carrot_grow_stages = [0,0.3,0.6,1]
@export var carrot_n_per_yield = 6
@export var carrot_p_per_yield = 27
@export var carrot_k_per_yield = 4
@export var carrot_n_happy_amount = 3
@export var carrot_p_happy_amount = 14
@export var carrot_k_happy_amount = 5
@export var carrot_sell_price = 44
@export var carrot_seed_price = 20
@export var carrot_water_per_yield := 0.75

@export_group("Corn")
@export var corn_grow_speed = (1.0/1600.0) # NEED TO CHANGE - SHOULD BE BASED ON NPK AMNTS
@export var corn_grow_stages = [0,0.16,0.33,0.5,0.66,1,1]
@export var corn_n_per_yield = 62	
@export var corn_p_per_yield = 8
@export var corn_k_per_yield = 2
@export var corn_n_happy_amount = 10
@export var corn_p_happy_amount = 1
@export var corn_k_happy_amount = 13
@export var corn_sell_price = 110
@export var corn_seed_price = 35
@export var corn_water_per_yield := 1.5

@export_group("Potato") #NEEDS TO BE DEFIENED SOMEONES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
@export var potato_grow_speed = (1.0/800.0) # NEED TO CHANGE - SHOULD BE BASED ON NPK AMNTS
@export var potato_grow_stages = [0,0.33,0.66,1]
@export var potato_n_per_yield = 20
@export var potato_p_per_yield = 3
@export var potato_k_per_yield = 30
@export var potato_n_happy_amount = 10
@export var potato_p_happy_amount = 1
@export var potato_k_happy_amount = 13
@export var potato_sell_price = 82
@export var potato_seed_price = 25
@export var potato_water_per_yield := 1.5
