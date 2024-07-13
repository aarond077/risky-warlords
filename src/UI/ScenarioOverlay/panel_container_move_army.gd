extends PanelContainer

@onready var warriors_label : Label = $VBoxContainer/HBoxContainer2/MarginContainer/WarriorsCounter
@onready var warriors_available_label : Label = $VBoxContainer/GridContainer/MarginWarriorsAvailable/WarriorsAvailableLabel
@onready var archers_label : Label = $VBoxContainer/HBoxContainer2/MarginContainer2/ArchersCounter
@onready var archers_available_label : Label = $VBoxContainer/GridContainer/MarginArchersAvailable/ArchersAvailableLabel
@onready var tanks_label : Label = $VBoxContainer/HBoxContainer2/MarginContainer3/TanksCounter
@onready var tanks_available_label : Label = $VBoxContainer/GridContainer/MarginTanksAvailable/TanksAvailableLabel

var moving_army : Dictionary = {"Warriors" : 0, "Archers" : 0, "Tanks" : 0}
var available_army : Dictionary 
var target_region : RegionNode
var warriors_name : String = "Warriors"
var archers_name : String = "Archers"
var tanks_name : String = "Tanks"

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "show_move_army_container", on_show_move_army_container)
	SignalBus.call_deferred("connect", "next_active_player", on_next_active_player)
	SignalBus.call_deferred("connect", "region_defeated", on_region_defeated)
func decrease_troop_label(
	troops_name : String,
	troops_label : Label,
	troops_available_label : Label):
	if(moving_army[troops_name] > 0):
		moving_army[troops_name] -= 1
		available_army[troops_name] += 1
		troops_label.text = str(moving_army[troops_name])
		troops_available_label.text = str(available_army[troops_name])
	
	
func increase_troop_label(
	troops_name : String,
	troops_label : Label,
	troops_available_label : Label):
	if(available_army[troops_name] != 0\
	and available_army_is_not_empty(troops_name)):
		moving_army[troops_name] += 1
		available_army[troops_name] -= 1
		troops_label.text = str(moving_army[troops_name])
		troops_available_label.text = str(available_army[troops_name])

func available_army_is_not_empty(troops_name : String) -> bool:
	if available_army[troops_name] == 1:
		if troops_name == warriors_name:
			return available_army[archers_name] != 0 or available_army[tanks_name] != 0
		elif troops_name == archers_name:
			return available_army[warriors_name] != 0 or available_army[tanks_name] != 0
		elif troops_name == tanks_name:
			return available_army[warriors_name] != 0 or available_army[archers_name] != 0
	return true
	
func update_available_army_label():
	warriors_available_label.text = str(available_army[warriors_name])
	archers_available_label.text = str(available_army[archers_name])
	tanks_available_label.text = str(available_army[tanks_name])

func reset_moving_army_label():
	warriors_label.text = str(0)
	archers_label.text = str(0)
	tanks_label.text = str(0)
	
func conquer_region():
	
	target_region.increase_army(
		moving_army["Warriors"],
		moving_army["Archers"],
		moving_army["Tanks"]
	)
	
	if(target_region.building != "Festung"):
		SignalBus.call_deferred(
				"emit_signal", 
				"remove_sprite", 
				target_region.building,
				target_region.region_name
				)
		target_region.building = ""

	
	var losing_player : Player = ScenarioDataManager.find_player_by_holder(target_region.holder)
	
	losing_player.regions.remove_node(
		target_region.region_name,
		losing_player.regions,
		ScenarioDataManager.scenario_map_name
	)
	
	
	ScenarioDataManager.active_player.regions.add_node(
		target_region.region_name,
		ScenarioDataManager.active_player.regions,
		ScenarioDataManager.scenario_map_name)
		
	target_region.holder = "Player " + str(ScenarioDataManager.active_player.player_index)
	moving_army = {"Warriors" : 0, "Archers" : 0, "Tanks" : 0}
	reset_moving_army_label()
	self.visible = false
	
	if(target_region.building == "Heiligtum"):
		losing_player.sanctuary_bonus = 0
	elif(target_region.building == "Forschungscenter"):
		losing_player.has_research_center = false
		losing_player.archer_upgrade = false
		losing_player.tank_upgrade = false
	
	var player_index : int = ScenarioDataManager.player_indexfunc()
	
	ScenarioDataManager.add_region_holder(target_region.region_name, player_index)
	

	ScenarioDataManager.remove_defeated_player(losing_player)
	
	if(ScenarioDataManager.game_end()):
		SignalBus.call_deferred("emit_signal", "game_end")
	
	SignalBus.call_deferred("emit_signal", "update_political_view")
	
func on_next_active_player():
	reset_moving_army_label()
	
func on_show_move_army_container(region_name : String, player : Player):
	SignalBus.call_deferred(
		"emit_signal",
		"pause_active_player_timer"
	)
	target_region = ScenarioDataManager.find_region_in_array(region_name)
	available_army = ScenarioDataManager.active_region.region_army
	update_available_army_label()
	self.visible = true
	
func on_region_defeated(attacking_region : RegionNode, defending_region : RegionNode):
	SignalBus.call_deferred(
		"emit_signal",
		"pause_active_player_timer"
	)
	print("i have no idea")
	target_region = defending_region
	available_army = attacking_region.region_army
	update_available_army_label()
	self.visible = true

func _on_warriors_increase_button_pressed():
	increase_troop_label(warriors_name, warriors_label, warriors_available_label)



func _on_warriors_decrease_button_pressed():
	decrease_troop_label(warriors_name, warriors_label, warriors_available_label)


func _on_archers_decrease_button_pressed():
	decrease_troop_label(archers_name, archers_label, archers_available_label)

func _on_archers_increase_button_pressed():
	increase_troop_label(archers_name, archers_label, archers_available_label)

func _on_tanks_decrease_button_pressed():
	decrease_troop_label(tanks_name, tanks_label, tanks_available_label)

func _on_tanks_increase_button_pressed():
	increase_troop_label(tanks_name, tanks_label, tanks_available_label)


func _on_cancel_button_pressed():
	if(not ScenarioDataManager.battle_phase_active):
		moving_army = {"Warriors" : 0, "Archers" : 0, "Tanks" : 0}
	
		SignalBus.call_deferred(
			"emit_signal",
			"continue_active_player_timer"
		)
	
		self.visible = false


func _on_confirm_button_pressed():
	ScenarioDataManager.active_region.region_army = available_army
	
	SignalBus.call_deferred(
		"emit_signal",
		"continue_active_player_timer"
	)
	
	if ScenarioDataManager.battle_phase_active:
		self.conquer_region()
	else:
		target_region.increase_army(
		moving_army["Warriors"],
		moving_army["Archers"],
		moving_army["Tanks"]
		)
		if(not target_region.owner == ScenarioDataManager.active_player):
			ScenarioDataManager.active_player.regions.add_node(
				target_region.region_name,
				ScenarioDataManager.active_player.regions,
				ScenarioDataManager.scenario_map_name)
			target_region.holder = "Player " + str(ScenarioDataManager.active_player.player_index)
		moving_army = {"Warriors" : 0, "Archers" : 0, "Tanks" : 0}
		reset_moving_army_label()
		self.visible = false
		ScenarioDataManager.decrease_action_points(1)
		var player_index : int = ScenarioDataManager.player_indexfunc()
		ScenarioDataManager.add_region_holder(target_region.region_name, player_index)
		SignalBus.call_deferred("emit_signal", "update_player_action_points_label", ScenarioDataManager.active_player)
		SignalBus.call_deferred("emit_signal", "update_political_view")
	SignalBus.emit_signal("update_army_count_labels")


#func _on_warriors_increase_button_button_down():
	#increase_troop_label(warriors_name, warriors_label, warriors_available_label)
#
#
#func _on_warriors_decrease_button_button_down():
	#decrease_troop_label(warriors_name, warriors_label, warriors_available_label)
#
#
#func _on_archers_decrease_button_button_down():
	#decrease_troop_label(archers_name, archers_label, archers_available_label)
#
#
#func _on_archers_increase_button_button_down():
	#increase_troop_label(archers_name, archers_label, archers_available_label)
#
#
#func _on_tanks_decrease_button_button_down():
	#decrease_troop_label(tanks_name, tanks_label, tanks_available_label)
#
#
#func _on_tanks_increase_button_button_down():
	#increase_troop_label(tanks_name, tanks_label, tanks_available_label)
