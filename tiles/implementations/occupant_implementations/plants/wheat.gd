class_name Wheat extends Plant

func tick() -> void:
	super()
	#print(growthPercentage)
	if(is_equal_approx(growthPercentage,0.002)):
		change_growth_stage.emit(0)
	if(is_equal_approx(growthPercentage,0.04)):
		change_growth_stage.emit(1)
	if(is_equal_approx(growthPercentage,0.08)):
		change_growth_stage.emit(2)
