extends Sprite2D

var full_sheet = preload("res://assets/cursor_images.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_viewport().mouse_entered.connect(_on_mouse_entered_window)
	get_viewport().mouse_exited.connect(_on_mouse_exited_window)

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Global.on_tool_changed.connect(set_cursor_from_atlas)
	set_cursor_from_atlas()

func _on_mouse_entered_window():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	show() # Show your custom sprite

func _on_mouse_exited_window():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	hide() # Hide your custom sprite so it doesn't "stick" to the edge

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

func set_cursor_from_atlas():
	
	var sheet_image = full_sheet.get_image()
	var region
	if Global.current_tool == Global.Tool.WATER:
		print("Cursoring")
		region = Rect2i(0, 0, 17, 14)
	elif Global.current_tool == Global.Tool.TILL:
		region = Rect2i(17, 0, 17, 14)
	elif Global.current_tool == Global.Tool.INSPECT:
		region = Rect2i(34, 0, 14, 14)
	else:
		region = Rect2i(48, 0, 9, 14)
	var cursor_img = sheet_image.get_region(region)
	# In software, you don't even need to resize! 
	# You can just set the Sprite's scale to 4.0
	var final_tex = ImageTexture.create_from_image(cursor_img)
	texture = final_tex
	centered = true # Or adjust offset for your hotspot
