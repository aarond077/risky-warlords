extends PanelContainer

@onready var food_label : Label = $VBoxContainer/HBoxContainer/FoodInput
@onready var warrior_counter_label : Label = $VBoxContainer/HBoxContainer2/MarginContainer/WarriorCounter
@onready var archer_counter_label : Label = $VBoxContainer/HBoxContainer2/MarginContainer2/ArcherCounter
@onready var tank_counter_label : Label = $VBoxContainer/HBoxContainer2/MarginContainer3/TankCounter
@onready var new_army : Dictionary = {"Warriors" : 0, "Archers" : 0, "Tanks" : 0}

func _ready():
	SignalBus.call_deferred("connect", "update_player_food_label", on_update_player_food_label)
	
func reset_select_army_input():
	update_food_label(ScenarioDataManager.active_player)
	warrior_counter_label.text = str(0)
	archer_counter_label.text = str(0)
	tank_counter_label.text = str(0)
	new_army = {"Warriors" : 0, "Archers" : 0, "Tanks" : 0}

func update_counter_label(label : Label, troop_name : String) -> void:
	label.text = str(new_army[troop_name])

func update_food_label(player : Player):
	food_label.text = str(player.resources["Food"])

func on_update_player_food_label(player : Player):
	update_food_label(player)
	

func _on_warrior_decrease_button_pressed() -> void:
	var troop_name : String = "Warriors"
	var active_player : Player = ScenarioDataManager.active_player
	if(new_army[troop_name] > 0):
		new_army[troop_name] -= 1
		active_player.add_resource_food(2)
	update_counter_label(warrior_counter_label, troop_name)
	update_food_label(active_player)

func _on_warrior_increase_button_pressed() -> void:
	var active_player : Player = ScenarioDataManager.active_player
	var troop_name : String = "Warriors"
	if(active_player.resources["Food"] > 1):
		new_army[troop_name] += 1
		active_player.reduce_resource_food(2)
	update_counter_label(warrior_counter_label, troop_name)
	update_food_label(active_player)

func _on_archer_decrease_button_pressed() -> void:
	var troop_name : String = "Archers"
	var active_player : Player = ScenarioDataManager.active_player
	if(new_army[troop_name] > 0):
		new_army[troop_name] -= 1
		active_player.add_resource_food(4)
	update_counter_label(archer_counter_label, troop_name)
	update_food_label(active_player)


func _on_archer_increase_button_pressed() -> void:
	var troop_name : String = "Archers"
	var active_player : Player = ScenarioDataManager.active_player
	if(active_player.resources["Food"] > 3):
		new_army[troop_name] += 1
		active_player.reduce_resource_food(4)
	update_counter_label(archer_counter_label, troop_name)
	update_food_label(active_player)


func _on_tank_decrease_button_pressed() -> void:
	var troop_name : String = "Tanks"
	var active_player : Player = ScenarioDataManager.active_player
	if(new_army[troop_name] > 0):
		new_army[troop_name] -= 1
		active_player.add_resource_food(5)
	update_counter_label(tank_counter_label, troop_name)
	update_food_label(active_player)


func _on_tank_increase_button_pressed() -> void:
	var troop_name : String = "Tanks"
	var active_player : Player = ScenarioDataManager.active_player
	if(active_player.resources["Food"] > 5):
		new_army[troop_name] += 1
		active_player.reduce_resource_food(6)
	update_counter_label(tank_counter_label, troop_name)
	update_food_label(active_player)
	

func _on_confirm_button_pressed():
	
	var new_warriors : int = new_army["Warriors"]
	var new_archers : int = new_army["Archers"]
	var new_tanks : int = new_army["Tanks"]
	if new_archers > 0:
		AudioManager.play_arrow()
	else:
		AudioManager.play_drawSword()
	var active_player_capital_name : String = ScenarioDataManager.active_player.capital
	var active_player_capital : RegionNode = ScenarioDataManager.find_region_in_array(active_player_capital_name)
	
	ScenarioDataManager.active_player.update_army(
		new_warriors,
		new_archers,
		new_tanks
		)
	
	ScenarioDataManager.add_army_to_region(
		active_player_capital,
		new_warriors,
		new_archers,
		new_tanks)
		
	SignalBus.emit_signal("update_army_count_labels")
		
	SignalBus.emit_signal("check_player_index")
		
	ScenarioDataManager.set_next_active_player()
		
	reset_select_army_input()
