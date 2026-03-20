extends Node2D
var occupant
func _ready() -> void:
	var tilemanager = get_parent().get_parent()
	
	if !tilemanager:
		return
	var cell = tilemanager.occupant_layer.local_to_map(position)
	occupant = tilemanager.map[tilemanager.tiles.vector_to_index(cell)].occupant
	
	if occupant is Machine:
		occupant.scene = self

func _process(delta: float) -> void:
	if occupant is Sprinkler:
		occupant.process(delta)
	
