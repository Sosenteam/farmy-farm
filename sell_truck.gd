extends Node2D

@onready var boxes_sprite = $Truck/Boxes
@onready var truck_sprite = $Truck/Truck
@onready var animation_player = $AnimationPlayer
@onready var particle1 = $Truck/GPUParticles2D2
@onready var particle2 = $Truck/GPUParticles2D

var items_in_truck = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_box_profile()
	particle1.emitting = false
	particle2.emitting = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# Adding an item to sell
func add_item(item):
	# item should be an item class so we can reference image, price, amount, etc.
	items_in_truck.append(item)
	
func set_box_profile():
	print("res://Assets/sell_truck/boxes/"+ str(items_in_truck.size()) +".png")
	boxes_sprite.texture = load("res://Assets/sell_truck/boxes/"+ str(items_in_truck.size()) +".png")

func send_off():
	truck_sprite.texture = load("res://Assets/sell_truck/closed_truck.png")
	particle1.emitting = true
	particle2.emitting = true
	animation_player.play("truck_leaving")
	#sell_items function here
	
func come_back():
	items_in_truck.clear() #might not be necesarry depending on how we sell items in future
	set_box_profile()
	particle1.emitting = true
	particle2.emitting = true
	truck_sprite.texture = load("res://Assets/sell_truck/closed_truck.png")
	animation_player.play("truck_returning")
	
	
	
#temporary, just to test shwoing boxes
func _on_static_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		add_item("ITEM")
		set_box_profile()
	if (items_in_truck.size() == 8 ):
		send_off()
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "truck_leaving"):
		particle1.emitting = false
		particle2.emitting = false
		come_back()
		
	if (anim_name == "truck_returning"):
		truck_sprite.texture = load("res://Assets/sell_truck/opened_truck.png")
		particle1.emitting = false
		particle2.emitting = false
