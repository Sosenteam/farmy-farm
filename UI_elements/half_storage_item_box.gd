extends Control

var slot_node = preload("res://inventory/slot.tscn")

# Called when the node enters the scene tree for the first time.
func init_me(name, items):
	$Box/Label.text = name
	for item in items:
		print(item)
		var slot = slot_node.instantiate()
		
		slot.set_slot(item)
		$Box/ItemBox/ScrollContainer/HBoxContainer.add_child(slot)
	

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
