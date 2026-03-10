class_name Tile

var ground:Ground
var occupant:Occupant

func _init(new_ground = Dirt,new_occupant = null) -> void:
	if(new_ground):
		ground = new_ground.new()
		ground.tile = self
	if(new_occupant):
		occupant = new_occupant.new()
		occupant.tile = self
	Global.on_tick.connect(tick)

func tick() -> void:
	ground.tick()
	occupant.tick()


static var constants = preload("res://tiles/tiles_resource.tres")
