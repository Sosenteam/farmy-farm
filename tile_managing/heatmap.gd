extends Node2D


@onready var manager = $".."


func _draw() -> void:
	
	for t in manager.map.size():
		var tile = manager.map[t]
		var x = manager.tiles.index_to_vector(t).x
		var y = manager.tiles.index_to_vector(t).y
		# All Color
		#var r:float = tile.ground.nitrogen
		#var g:float = tile.ground.phosphorus
		#var b:float = tile.ground.potassium
		#draw_rect(Rect2(x*16,y*16,16,16),Color(r,g,b,0.1))
		
		var a:float = tile.ground.moisture_percent
		draw_rect(Rect2(x*16,y*16,16,16),Color(1,0,0,remap(a,0,1,0,0.25)))

func _process(delta: float) -> void:
	queue_redraw()
