class_name Corn extends Plant
static var stages = constants.corn_grow_stages

func tick() -> void:

	# PLEASE MAKE A FASTER WAY OF DOING THIS (if possible w/o for loops)
	if(is_equal_approx(growthPercentage,stages[0])):
		change_growth_stage.emit("corn",0)
	if(is_equal_approx(growthPercentage,stages[1])):
		change_growth_stage.emit("corn",1)
	if(is_equal_approx(growthPercentage,stages[2])):
		change_growth_stage.emit("corn",2)
	if(is_equal_approx(growthPercentage,stages[3])):
		change_growth_stage.emit("corn",3)
	if(is_equal_approx(growthPercentage,stages[4])):
		change_growth_stage.emit("corn",4)
	# Increase the growth percent
	growthPercentage+=constants.corn_grow_speed
