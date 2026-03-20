extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var pos = get_global_mouse_position()
	pos = floor(pos/16)*16
	#pos.y
	global_position = pos
	
