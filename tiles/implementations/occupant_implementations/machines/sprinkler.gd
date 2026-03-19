class_name Sprinkler extends Machine

var ticks_between_waterings:int = 250
var ticks_since_last_watering:int = 0;
var ticks_to_saturate_dirt:int = 12

func _init():
	machine_name = &"sprinkler"
	ticks_since_last_watering = ticks_between_waterings - 10

func tick() -> void:
	if ticks_since_last_watering > ticks_between_waterings:
		var surroundingTiles = tile.tiles.get_surrounding_tiles(tile.index)
		
		if ticks_since_last_watering - ticks_between_waterings < (ticks_to_saturate_dirt+1):
			for surrounding in surroundingTiles:
				if surrounding:
					if(surrounding.ground is Dirt):
						surrounding.ground.change_water(1.0 / ticks_to_saturate_dirt)
		else:
			ticks_since_last_watering = 0
	
	ticks_since_last_watering += 1;
