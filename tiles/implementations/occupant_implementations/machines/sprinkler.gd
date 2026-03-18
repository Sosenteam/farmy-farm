class_name Sprinkler extends Machine

var ticks_between_waterings:int = 320
var ticks_since_last_watering:int = 310
var ticks_to_saturate_dirt:int = 8

func _init():
	machine_name = &"sprinkler"
	ticks_since_last_watering = 310

func tick() -> void:
	#print(ticks_since_last_watering)
	if ticks_since_last_watering > ticks_between_waterings:
		var surroundingTiles = tile.tiles.get_surrounding_tiles(tile.index)
		
		for surrounding in surroundingTiles:
			if surrounding:
				if(surrounding.ground is Dirt):
					surrounding.ground.change_water(0.1)
					#print("watering " + str(surrounding.index))
	ticks_since_last_watering += 1;
