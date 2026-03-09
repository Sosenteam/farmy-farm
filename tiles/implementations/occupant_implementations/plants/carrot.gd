class_name Carrot extends Plant
static var stages = constants.carrot_grow_stages

func tick() -> void:

	# PLEASE MAKE A FASTER WAY OF DOING THIS (if possible w/o for loops)
	if(is_equal_approx(growthPercentage,stages[0])):
		change_growth_stage.emit("carrot",0)
	if(is_equal_approx(growthPercentage,stages[1])):
		change_growth_stage.emit("carrot",1)
	if(is_equal_approx(growthPercentage,stages[2])):
		change_growth_stage.emit("carrot",2)
	if(is_equal_approx(growthPercentage,stages[3])):
		change_growth_stage.emit("carrot",3)
	# Increase the growth percent
	growthPercentage+=constants.carrot_grow_speed
