extends Camera2D

var middle_button_pressed

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 3:
			middle_button_pressed = event.pressed
	if event is InputEventMouseMotion:
		if middle_button_pressed:
			position -= event.screen_relative/zoom.x
