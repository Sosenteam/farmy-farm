extends Control

@onready var HBox = $HBoxContainer
@onready var ItemBox = preload("res://UI_elements/item_box.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i = 0
	for array in Global.inventory.values():
		var newThing = ItemBox.instantiate()
		newThing.init_me(Global.inventory.keys()[i], array)
		$HBoxContainer.add_child(newThing)
		
		i+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
