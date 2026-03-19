@abstract
class_name Machine extends Occupant

var machine_name:StringName = ""
var scene:Node2D
signal pick_up

func _pick_up():
	tile.delete_occupant()
	pick_up.emit()
	#TODO: put it in your inventory :3
