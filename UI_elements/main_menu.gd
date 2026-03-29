extends CanvasLayer

@onready var title = %Title
@onready var start_button = %StartButton
@onready var quit_button = %QuitButton
@onready var menu_container = $Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
	menu_container.modulate.a = 1.0

func _on_start_button_pressed() -> void:

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(menu_container, "modulate:a", 0.0, 1.0)
	await tween.finished
	
	get_tree().paused = false
	queue_free()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
