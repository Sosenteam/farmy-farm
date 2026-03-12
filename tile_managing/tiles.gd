extends Resource


@export var width: int = 5 # Width of Tile Array
@export var height: int = 5 # Height of Tile Array

var map: Array[Tile] # Main Tile Array
var cells := 0:
	get:
		return width*height 
var length := 0:
	get:
		return map.size()

func set_tile(pos:Vector2i,data:Tile) -> void:
	if pos.y*pos.x < cells:   #Prevent Overflowing
		map[(pos.y * width) + (pos.x)] = data

func get_tile(pos:Vector2i) -> Tile:
	if pos.y*pos.x < cells:   #Prevent Overflowing
		return map[(pos.y * width) + (pos.x)]
	else:
		return null

func vector_to_index(vector:Vector2i) -> int:
	return (vector.y * width) + (vector.x)

func index_to_vector(index:int)-> Vector2i:
	var vect: Vector2i
	vect.x = index % width 
	vect.y = (index-vect.x) / width
	return vect

func is_in(vector:Vector2i) -> bool:
	if(vector.x>width-1||vector.y>height-1):
		return false
	else:
		return true

## Negative adds size to left, up | Positive adds size to right, down
func add_size(width_change: int,height_change: int):
	#Vertical Change
	if height_change > 0:
		for j in range(0,height_change):
			for i in range(0,width):
				map.push_back(Tile.new())
		height+=height_change
	elif height_change <0:
		for j in range(0,abs(height_change)):
			for i in range(0,width):
				map.push_front(Tile.new())
		height+=abs(height_change)
	# Horizontal Change
	if width_change > 0:
		for j in abs(width_change):
			for row in height:
				map.insert((row*width)+width+row,Tile.new())
			width+=1
	elif width_change < 0:
		for j in abs(width_change):
			for row in height:
				map.insert((row*width)+row,Tile.new())
			width+=1
	## STUFF
	for t in map.size():
		map[t].index = t
	
	
func get_surrounding_tiles(index) -> Array[Tile]:
	var return_array:Array[Tile] = []
	return_array.resize(8)
	var position = index_to_vector(index)
	var has_top = position.y > 0
	var has_bottom = position.y < height - 1
	var has_left = position.x > 0
	var has_right = position.x < width - 1

	# SIDES
	return_array[0] = map[index-width] if has_top else null
	return_array[1] = map[index+1] if has_right else null
	return_array[2] = map[index+width] if has_bottom else null
	return_array[3] = map[index-1] if has_left else null
	# CORNERS
	return_array[4] = map[index - width - 1] if has_top and has_left else null
	return_array[5] = map[index - width + 1] if has_top and has_right else null
	return_array[6] = map[index + width + 1] if has_bottom and has_right else null
	return_array[7] = map[index + width - 1] if has_bottom and has_left else null
	return return_array
