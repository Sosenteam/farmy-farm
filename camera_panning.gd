extends Camera2D

@export var camera_speed = 1.5
var middle_button_pressed
var direction
var keyboard_pressed

func _input(event: InputEvent) -> void:
	#print("Hovered: ", get_viewport().gui_get_hovered_control())
	if event is InputEventMouseButton or event is InputEventPanGesture:
		var hovered = get_viewport().gui_get_hovered_control()
		if hovered and hovered.mouse_filter == Control.MOUSE_FILTER_STOP:
			return
	# trackpad panning (Two-finger swipe on Mac/Laptops)
	if event is InputEventPanGesture:
		# sensitivity
		position -= event.delta * 20.0 / zoom.x
	# Mouse panning (Middle click and drag)
	if event is InputEventMouseButton:
		if event.button_index == 3:
			middle_button_pressed = event.pressed
	
	if event is InputEventMouseMotion:
		if middle_button_pressed:
			position -= event.screen_relative/zoom.x
			
	if event is InputEventScreenDrag:
		position -= event.screen_relative/zoom.x
	#---Keyboard---#
func _process(_delta) -> void:
	position = position.clamp(Vector2(-200,-200),Vector2(200,200)) 
	direction = Input.get_vector("camera_left","camera_right","camera_up","camera_down")
	position += direction*camera_speed
