extends Area2D

enum PlantType {NONE,WHEAT,EGGPLANT}

var plant = Plant.new()

@onready var grow_timer = $Plant/GrowTimer


func _ready() -> void:
	plant.type = PlantType.WHEAT
	plant.node = $Plant
	plant.node.play("wheat") #Make change with plant type
	grow_timer.wait_time = 1 #Will eventually depend on the plant type
	grow_timer.timeout.connect(on_grow)
	grow_timer.start()


func on_grow() -> void:
	
	plant.node.frame = plant.stage
	print("Stage= ",plant.stage)
	if(plant.stage<3): 
		plant.stage+= 1
	grow_timer.start()

class Plant:
	var type = PlantType.NONE
	var stage: int = 0
	var watered: bool = false
	var node: AnimatedSprite2D
