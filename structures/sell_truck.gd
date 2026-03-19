extends Node2D

@onready var boxes_sprite = $Truck/Boxes
@onready var truck_sprite = $Truck/Truck
@onready var animation_player = $AnimationPlayer
@onready var particle1 = $Truck/GPUParticles2D2
@onready var particle2 = $Truck/GPUParticles2D

var items_in_truck = []
var is_moving = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_box_profile()
	particle1.emitting = false
	particle2.emitting = false
	Inventory.sell_items.connect(send_off)
	Inventory.update_truck_boxes.connect(update_boxes)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# Adding an item to sell
func add_item(item):
	items_in_truck.append(item)
	
func set_box_profile():
	var total_quantity = 0
	for item in items_in_truck:
		total_quantity += item.quantity
	
	var box_count = ceil(total_quantity / 5.0)
	if box_count > 9:
		box_count = 9
	
	if box_count <= 0:
		boxes_sprite.texture = null
		return
		
	print("res://assets/sell_truck/boxes/"+ str(box_count) +".png")
	boxes_sprite.texture = load("res://assets/sell_truck/boxes/"+ str(int(box_count)) +".png")

func update_boxes(items):
	if is_moving: return
	items_in_truck = items
	set_box_profile()

func send_off(sold_items):
	is_moving = true
	items_in_truck = sold_items
	set_box_profile()
	truck_sprite.texture = load("res://assets/sell_truck/closed_truck.png")
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
	if is_moving: return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Global.open_ui.emit("sell")
	#if event is InputEventMouseButton and event.pressed:
		#add_item("ITEM")
		#set_box_profile()
	#if (items_in_truck.size() == 8 ):
		#send_off()
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "truck_leaving"):
		particle1.emitting = false
		particle2.emitting = false
		come_back()
		
	if (anim_name == "truck_returning"):
		truck_sprite.texture = load("res://assets/sell_truck/opened_truck.png")
		particle1.emitting = false
		particle2.emitting = false
		is_moving = false
