class_name Corn extends Plant
static var stages = constants.corn_grow_stages

func tick() -> void:

	for i in stages.size():
		if is_equal_approx(growthPercentage, stages[i]):
			change_growth_stage.emit("corn", i)
			break 
	# Increase the growth percent
	growthPercentage+=constants.corn_grow_speed
