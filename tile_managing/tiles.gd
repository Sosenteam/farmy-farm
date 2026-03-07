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

func set_tile(pos:Vector2i,data:Tile):
	if length > cells:   #Prevent Overflowing
		map[(pos.y * width) + (pos.x)] = data

func get_tile(pos:Vector2i):
	if length > cells:   #Prevent Overflowing
		return map[(pos.y * width) + (pos.x)]
