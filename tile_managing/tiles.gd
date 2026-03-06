extends Resource

@export var tiles = [] # Main Tile Array
@export var width :int = 5 # Width of Tile Array
@export var height :int = 5 # Height of Tile Array

var length := 0:
	get:
		return tiles.size()
