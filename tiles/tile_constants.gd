extends Resource

# 480 ticks ish per crop growth
@export var TEST:float = 10
const ticks_per_second:int = 16
const ticks_per_day:int = ticks_per_second * 90
@export var BASE_WATER_LOSS:float = 1.0/ticks_per_day
@export var BASE_GROWTH_RATE:float = 1.0/480.0 # 0.00208333333
@export var BASE_NUTRIENT_UPTAKE:float = 0.25/ticks_per_day

@export_category("Crop Constants")

@export_group("Wheat")
@export var wheat_grow_speed = 0.01 # Make Randomised?
@export var wheat_grow_stages = [0,0.25,0.5,0.75,1]

@export_group("Carrot")
@export var carrot_grow_speed = 0.01 # Make Randomised?
@export var carrot_grow_stages = [0,0.3,0.6,1]

@export_group("Corn")
@export var corn_grow_speed = 0.01 # Make Randomised?
@export var corn_grow_stages = [0,0.25,0.5,0.75,1]
