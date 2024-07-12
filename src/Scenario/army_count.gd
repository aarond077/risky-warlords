extends Node2D

func find_army_count_label_by_name(region_name: String) -> ArmyCountLabel:
	for child in get_children():
		if child.name == region_name:
			return child
	return null
