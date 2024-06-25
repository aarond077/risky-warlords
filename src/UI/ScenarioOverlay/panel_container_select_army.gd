extends PanelContainer

@onready var food_label : Label = $VBoxContainer/HBoxContainer/FoodInput
@onready var warrior_counter_label : Label = $VBoxContainer/HBoxContainer2/MarginContainer/WarriorCounter
@onready var archer_counter_label : Label = $VBoxContainer/HBoxContainer2/MarginContainer2/ArcherCounter
@onready var tank_counter_label : Label = $VBoxContainer/HBoxContainer2/MarginContainer3/TankCounter

func reset_select_army_input():
	food_label.text = str(10)
	warrior_counter_label.text = str(0)
	archer_counter_label.text = str(0)
	tank_counter_label.text = str(0)

func update_counter_label(label : Label, troop : String) -> void:
	label.text = str(ScenarioDataManager.active_player.army[troop])
	
func _on_warrior_decrease_button_pressed() -> void:
	var troop_name : String = "Warriors"
	if(ScenarioDataManager.active_player.army[troop_name] > 0):
		ScenarioDataManager.active_player.army[troop_name] -= 1
	update_counter_label(warrior_counter_label, troop_name)


func _on_warrior_increase_button_pressed() -> void:
	var troop_name : String = "Warriors"
	ScenarioDataManager.active_player.army[troop_name] += 1
	update_counter_label(warrior_counter_label, troop_name)

func _on_archer_decrease_button_pressed() -> void:
	var troop_name : String = "Archers"
	if(ScenarioDataManager.active_player.army[troop_name] > 0):
		ScenarioDataManager.active_player.army[troop_name] -= 1
	update_counter_label(archer_counter_label, troop_name)


func _on_archer_increase_button_pressed() -> void:
	var troop_name : String = "Archers"
	ScenarioDataManager.active_player.army[troop_name] += 1
	update_counter_label(archer_counter_label, troop_name)


func _on_tank_decrease_button_pressed() -> void:
	var troop_name : String = "Tanks"
	if(ScenarioDataManager.active_player.army[troop_name] > 0):
		ScenarioDataManager.active_player.army[troop_name] -= 1
	update_counter_label(tank_counter_label, troop_name)


func _on_tank_increase_button_pressed() -> void:
	var troop_name : String = "Tanks"
	ScenarioDataManager.active_player.army[troop_name] += 1
	update_counter_label(tank_counter_label, troop_name)
	



func _on_confirm_button_pressed():
	var new_warriors : int = int(warrior_counter_label.text)
	var new_archers : int = int(archer_counter_label.text)
	var new_tanks : int = int(tank_counter_label.text)
	var active_player_capital_name : String = ScenarioDataManager.active_player.capital
	var active_player_capital : RegionNode = ScenarioDataManager.find_region_in_array(active_player_capital_name)
	
	
	ScenarioDataManager.add_army_to_region(
		active_player_capital,
		new_warriors,
		new_archers,
		new_tanks)
		
	reset_select_army_input()
