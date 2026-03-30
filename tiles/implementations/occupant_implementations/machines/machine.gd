@abstract
class_name Machine extends Occupant

var machine_name:StringName = ""
var scene:Node2D
signal pick_up(machine_name:String, count:int)

func _pick_up():
	pick_up.emit(machine_name, 1)

func delete_occupant():
	scene.queue_free()
