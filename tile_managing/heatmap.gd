extends Node2D


@onready var manager = $".."


func _draw() -> void:
	var r:float = 0
	var g:float = 0
	var b:float = 0
	for t in manager.map.size():
		var tile = manager.map[t]
		r = tile.ground.nitrogen
		g = tile.ground.phosphorus
		b = tile.ground.potassium
		var x = manager.tiles.index_to_vector(t).x
		var y = manager.tiles.index_to_vector(t).y
		draw_rect(Rect2(x,y,16,16),Color(r,g,b,0.5))

func _process(delta: float) -> void:
	queue_redraw()
