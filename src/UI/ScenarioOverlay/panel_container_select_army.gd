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
	var troop_name : String = "Warrior"
	if(ScenarioDataManager.active_player.army["Warrior"] > 0):
		ScenarioDataManager.active_player.army["Warrior"] -= 1
	update_counter_label(warrior_counter_label, troop_name)


func _on_warrior_increase_button_pressed() -> void:
	var troop_name : String = "Warrior"
	ScenarioDataManager.active_player.army["Warrior"] += 1
	update_counter_label(warrior_counter_label, troop_name)

func _on_archer_decrease_button_pressed() -> void:
	var troop_name : String = "Archer"
	if(ScenarioDataManager.active_player.army["Warrior"] > 0):
		ScenarioDataManager.active_player.army["Archer"] -= 1
	update_counter_label(archer_counter_label, troop_name)


func _on_archer_increase_button_pressed() -> void:
	var troop_name : String = "Archer"
	ScenarioDataManager.active_player.army["Archer"] += 1
	update_counter_label(archer_counter_label, troop_name)


func _on_tank_decrease_button_pressed() -> void:
	var troop_name : String = "Tank"
	if(ScenarioDataManager.active_player.army["Warrior"] > 0):
		ScenarioDataManager.active_player.army["Tank"] -= 1
	update_counter_label(tank_counter_label, troop_name)


func _on_tank_increase_button_pressed() -> void:
	var troop_name : String = "Tank"
	ScenarioDataManager.active_player.army["Tank"] += 1
	update_counter_label(tank_counter_label, troop_name)
	



func _on_confirm_button_pressed():
	reset_select_army_input()
