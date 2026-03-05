extends Node

signal on_tick
var tick: int = 0

@onready var tick_timer = $TickTimer


func _on_tick() -> void:
	tick+=1
	on_tick.emit()
