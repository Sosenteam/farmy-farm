class_name Tile

var ground:Ground
var occupant:Occupant

func tick() -> void:
	ground.tick()
	occupant.tick()

static var constants = preload("res://tiles/tiles_resource.tres")
