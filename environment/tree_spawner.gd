extends Node2D

@export var tree_texture: Texture2D = preload("res://assets/tree.png")
@export var tree_count: int = 1000
@export var forest_depth: float = 200.0
@export var spawn_buffer: float = 4.0

func _ready() -> void:
	y_sort_enabled = true
	z_index = 5
	
	var grass_layer = get_parent().get_node_or_null("Base grass")
	if not grass_layer:
		return
		
	var used_rect = grass_layer.get_used_rect()
	var tile_size = grass_layer.tile_set.tile_size
	
	# Convert tile rect to pixel coordinates
	var map_left = used_rect.position.x * tile_size.x
	var map_top = used_rect.position.y * tile_size.y
	var map_width = used_rect.size.x * tile_size.x
	var map_height = used_rect.size.y * tile_size.y
	
	var map_right = map_left + map_width
	var map_bottom = map_top + map_height
	for i in range(tree_count):
		_spawn_random_tree(map_left, map_right, map_top, map_bottom)

func _spawn_random_tree(left, right, top, bottom):
	var tree = Sprite2D.new()
	tree.texture = tree_texture
	
	# Randomly pick which side of the map to spawn on
	var side = randi() % 4
	var pos = Vector2.ZERO
	
	match side:
		0: # Top Edge (Expands Downwards into map)
			pos.x = randf_range(left, right)
			pos.y = randf_range(top + spawn_buffer, top + forest_depth)
		1: # Bottom Edge (Expands Upwards into map)
			pos.x = randf_range(left, right)
			pos.y = randf_range(bottom - forest_depth, bottom - spawn_buffer)
		2: # Left Edge (Expands Rightwards into map)
			pos.x = randf_range(left + spawn_buffer, left + forest_depth)
			pos.y = randf_range(top, bottom)
		3: # Right Edge (Expands Leftwards into map)
			pos.x = randf_range(right - forest_depth, right - spawn_buffer)
			pos.y = randf_range(top, bottom)
			
	tree.position = pos
	
	# Visual variety
	tree.scale = Vector2.ONE * randf_range(0.9, 1.2)
	tree.rotation_degrees = randf_range(-5, 5)
	tree.flip_h = randi() % 2 == 0
	
	# Better pivot at the base for sorting
	tree.offset = Vector2(0, -tree.texture.get_height() / 2.0)
	
	add_child(tree)
