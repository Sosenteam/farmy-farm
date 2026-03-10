class_name Wheat extends Plant
static var stages = constants.wheat_grow_stages

func tick() -> void:
	
	for i in stages.size():
		if is_equal_approx(growthPercentage, stages[i]):
			change_growth_stage.emit("wheat", i)
			break 
			
	growthPercentage+=constants.wheat_grow_speed
