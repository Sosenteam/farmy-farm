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

@export_group("Fish")
@export var fish_n_add = 25
@export var fish_p_add = 4
@export var fish_k_add = 3
@export var fish_price = 35

@export_group("Bone")
@export var bone_n_add = 10
@export var bone_p_add = 20
@export var bone_k_add = 0
@export var bone_price = 35

@export_group("Seaweed")
@export var seaweed_n_add = 4
@export var seaweed_p_add = 0
@export var seaweed_k_add = 12
@export var seaweed_price = 25


@export_category("Machines")
@export_group("Sprinkler")
@export var sprinkler_image = preload("res://assets/items/sprinkler.png")
@export var sprinkler_name = "Sprinkler"
