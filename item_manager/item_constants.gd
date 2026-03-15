extends Resource

# 480 ticks ish per crop growth

@export_category("Crops")

@export_group("Wheat")
@export var wheat_image = preload("res://assets/items/wheat.png")
@export var wheat_name = "Wheat"

@export_group("Carrot")
@export var carrot_image = preload("res://assets/items/carrot.png")
@export var carrot_name = "Carrot"

@export_group("Corn")
@export var corn_image = preload("res://assets/items/corn.png")
@export var corn_name = "Corn"

@export_category("Seeds")

@export_group("Wheat Seed")
@export var wheat_seed_image = preload("res://assets/items/wheat_bag.png")
@export var wheat_seed_name = "Wheat Seeds"
@export var wheat_seed_plants = "Wheat"

@export_group("Carrot Seed")
@export var carrot_seed_image = preload("res://assets/items/carrot_bag.png")
@export var carrot_seed_name = "Carrot Seeds"
@export var carrot_seed_plants = "Carrot"

@export_group("Corn Seed")
@export var corn_seed_image = preload("res://assets/items/corn_bag.png")
@export var corn_seed_name = "Corn Seeds"
@export var corn_seed_plants = "Corn"
