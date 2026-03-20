extends Resource

# 480 ticks ish per crop growth

const ITEMS_SHEET = preload("res://assets/items.png")

@export_category("Crops")

@export_group("Wheat")
@export var wheat_coords = Vector2i(2, 1)
@export var wheat_name = "Wheat"

@export_group("Carrot")
@export var carrot_coords = Vector2i(0, 1)
@export var carrot_name = "Carrot"

@export_group("Corn")
@export var corn_coords = Vector2i(1, 1)
@export var corn_name = "Corn"

@export_category("Seeds")

@export_group("Wheat Seed")
@export var wheat_seed_coords = Vector2i(2, 0)
@export var wheat_seed_name = "Wheat Seeds"
@export var wheat_seed_plants = "Wheat"

@export_group("Carrot Seed")
@export var carrot_seed_coords = Vector2i(0, 0)
@export var carrot_seed_name = "Carrot Seeds"
@export var carrot_seed_plants = "Carrot"

@export_group("Corn Seed")
@export var corn_seed_coords = Vector2i(1, 0)
@export var corn_seed_name = "Corn Seeds"
@export var corn_seed_plants = "Corn"

@export_category("Fertilizer")

@export_group("Fish")
@export var fish_coords = Vector2i(2, 2)
@export var fish_name = "Fish Paste"
@export var fish_n_add = 25
@export var fish_p_add = 4
@export var fish_k_add = 3
@export var fish_price = 35

@export_group("Bone")
@export var bone_coords = Vector2i(0, 2)
@export var bone_name = "Bone Meal"
@export var bone_n_add = 10
@export var bone_p_add = 20
@export var bone_k_add = 0
@export var bone_price = 35

@export_group("Seaweed")
@export var seaweed_coords = Vector2i(1, 2)
@export var seaweed_name = "Seaweed Extract"
@export var seaweed_n_add = 4
@export var seaweed_p_add = 0
@export var seaweed_k_add = 12
@export var seaweed_price = 25

@export_category("Machines")

@export_group("Sprinkler")
@export var sprinkler_coords = Vector2i(0, 3)
@export var sprinkler_name = "Sprinkler"
@export var sprinkler_price = 100
