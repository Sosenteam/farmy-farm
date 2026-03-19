extends Node2D

func _ready() -> void:
	var tilemanager = get_parent().get_parent()
	
	if !tilemanager:
		return
	var cell = tilemanager.occupant_layer.local_to_map(position)
	var occupant = tilemanager.map[tilemanager.tiles.vector_to_index(cell)].occupant
	
	if occupant is Machine:
		occupant.scene = self



func _process(delta: float) -> void:
	#specifically for the sprinkler
	if get(&"animation") == &"watering":
		print("wateriong")
		for child in get_children():
			if child is GPUParticles2D:
				child.rotation += delta * 15.0
				child.emitting = true
	else:
		for child in get_children():
			if child is GPUParticles2D:
				child.emitting = false
