extends Control


func _ready() -> void:
	Global.open_ui.connect(func(ui): if (ui == "sell"): get_parent().show())



func _on_close_button_pressed() -> void:
	get_parent().hide()
