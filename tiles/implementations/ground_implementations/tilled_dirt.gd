class_name TilledDirt extends Dirt

func _init(dirt: Dirt) -> void:
	for p in dirt.get_property_list():
		if p.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			self.set(p.name, dirt.get(p.name))
