class_name Carrot extends Plant
static var stages = constants.carrot_grow_stages

func tick() -> void:

	for i in stages.size():
		if is_equal_approx(growthPercentage, stages[i]):
			change_growth_stage.emit("carrot", i)
			break 
	# Increase the growth percent
	growthPercentage+=constants.carrot_grow_speed
