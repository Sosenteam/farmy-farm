extends Node2D

var tiles_resource = preload("res://tile_managing/tiles.tres")
var tiles = tiles_resource.tiles



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.on_tick.connect(on_tick)



func on_tick():
	for tile in tiles:
		tile.tick()
