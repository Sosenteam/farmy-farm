extends Resource

# 480 ticks ish per crop growth
@export var TEST:float = 10

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
