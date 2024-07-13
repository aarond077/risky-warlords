extends Node2D

@export var scenario_map_name : String
@export var scenario_players : Array[Player]
@export var scenario_region_graph : RegionGraph
@export var maps : Array[String]


@onready var active_region : RegionNode
@onready var active_region_color : String
@onready var active_player : Player
@onready var building_coordinates : Dictionary
@onready var banner_coordinates : Dictionary
@onready var battle_phase_active : bool = false
@onready var start_round_active : bool = false
@onready var battle_container_shown : bool = false
@onready var capitals : Array
@onready var political_view_active : bool = false



# Called when the node enters the scene tree for the first time.
func _ready():
	self.scenario_region_graph = RegionGraph.new()
	SignalBus.call_deferred("connect", "set_political_view", player_indexfunc)
	
func game_end():
	return scenario_players.size() == 1
	
func map_index_to_color(index) -> Color:
	var color_code : Color
	var rdm : float = randf_range(0.6,0.8)
	var color : String = ScenarioDataManager.scenario_players[index].player_color
	if color == "Blue":
		color_code = Color(0.2,0,rdm,0.8)
	elif color == "Orange":
		color_code = Color(1,rdm,0,0.7)
	elif color == "Purple":
		color_code = Color(rdm,0.2,0.7,0.7)
	elif color == "Yellow":
		color_code = Color(rdm,0.85,0,0.7)
	else:
		color_code = Color(1,1,1,0.4)
	return color_code
	
func load_banner_coordinates(map_name : String):
	self.banner_coordinates = DataFileManager.import_file("res://data/Maps/" \
	+ map_name + "/" + map_name + "FlagPositions.txt")
	#"res://data/Maps/Bucht von Dessus/Bucht von DessusFlagPositions.txt"

func player_defeated(player : Player):
	for region in player.regions.region_array:
		if region.region_name == player.capital:
			return false
	return true

func remove_defeated_player(player : Player):
	if player_defeated(player):
		scenario_region_graph.remove_regions_player_data(player)
		scenario_players.erase(player)
	
func reset_player_army_movement():
	for player in scenario_players:
		player.reset_army_movement()

func reset_battle_phase():
	battle_phase_active = false
	battle_container_shown = false
	
func find_player_by_holder(region_holder : String) -> Player:
	for player in scenario_players:
		var player_name : String = "Player " + str(player.player_index)
		if player_name == region_holder:
			return player
	return null
	
func update_player_action_points():
	for player in self.scenario_players:
		player.update_action_points()
	
func update_player_resources():
	for player in self.scenario_players:
		player.update_resources()

func update_player_army(warriors : int, archers : int, tanks : int):
	for player in self.scenario_players:
		player.update_army(warriors, archers, tanks)

func decrease_action_points(costs : int) -> void:
	active_player.action_points -= costs

func add_army_to_region(
	region : RegionNode,
	warriors : int,
	archers : int,
	tanks : int ) -> void:
	region.increase_army(warriors, archers, tanks)
	

func find_region_in_array(region_name : String) -> RegionNode:
	for region in scenario_region_graph.region_array:
		if region.region_name == region_name:
			return region
	return null
	
func find_active_region_in_array(region_name : String):
	for region in self.scenario_region_graph.region_array:
		if region_name == region.region_name:
			self.active_region = region
	return self.active_region
	
func region_is_accessable_for_attack(region_name : String):
	var target_region : RegionNode = self.find_region_in_array(region_name)
	
	if not active_region.army_ready_to_attack():
		return false
		
	if not active_region.region_owner_index == active_player.player_index:
		return false
	for neighbour in active_region.neighbours:
		if neighbour == target_region:
			if target_region.holder != active_region.holder \
				and target_region.holder != "":
				return true
	return false
		

func region_is_accessable_for_movement(region_name : String):
	var target_region : RegionNode = self.find_region_in_array(region_name)
	
	if not active_region.army_ready_to_attack():
		return false
	
	for player_region in active_player.regions.region_array:
		if player_region.region_name == target_region.region_name:
			return true
		else:
			var scenario_graph_region : RegionNode = self.find_region_in_array(player_region.region_name)
			for neighbour in scenario_graph_region.neighbours:
				var active_player_name : String = "Player " + str(active_player.player_index) 
				if neighbour.region_name == target_region.region_name \
					and (active_player_name == target_region.holder \
					or target_region.holder == ""):
					return true
	return false
	
func add_region_holder(region_name : String, player_index : int):
	for region in self.scenario_region_graph.region_array:
		if region.region_name == region_name:
			region.region_owner_index = player_index
			region.holder = "Player " + str(player_index)
	

	
# sets the capitals according to the map capitals
func set_scenario_players_capitals(capitals) -> void:
	var rand_capital_index : int
	for player in self.scenario_players:
		player.regions = RegionGraph.new()

		rand_capital_index = randi_range(0, capitals.size()-1)
		while(player.capital == capitals[rand_capital_index]):
			rand_capital_index = randi_range(0, capitals.size()-1)
		player.capital = capitals[rand_capital_index]
		
		#player.add_region_to_array(player.capital)
		
		add_region_holder(player.capital, player.player_index)
		
		player.regions.add_node(
			player.capital,  
			player.regions, 
			ScenarioDataManager.scenario_map_name)
		
		capitals.remove_at(rand_capital_index)
	add_building_to_capitals()

func add_building_to_capitals():
	for player in scenario_players:
		var capital_region : RegionNode = self.find_region_in_array(player.capital)
		capital_region.building = "Festung"
	
func set_start_scenario_active_player():
	self.active_player = scenario_players[0]
	SignalBus.call_deferred("emit_signal", "next_active_player")

func player_has_possible_battles(next_player : Player):
	for region in scenario_region_graph.region_array:
		if region.holder == "Player " + str(next_player.player_index) and region.count_army() > 0:
			for neighbour in region.neighbours:
				if neighbour.holder != "" and neighbour.holder != region.holder:
					return true
	return false
		

func set_next_active_player():
	#if(ScenarioDataManager.battle_phase_active):
		#var next_player =  scenario_players[active_player.player_index]
		#var player_not_found : bool = false
		#while(not player_has_possible_battles(next_player) and not player_not_found):
			#if next_player.player_index == 1:
				#player_not_found = true
				#active_player = scenario_players[0]
				#SignalBus.call_deferred("emit_signal", "init_start_round")
			#else:
				#if(next_player.player_index < scenario_players.size()):
					#next_player = scenario_players[next_player.player_index]
				#else:
					#next_player = scenario_players[0]
		#if(not player_not_found):
			#active_player = next_player
			
				
	#else:		
		if(active_player.player_index < scenario_players.size()):
			active_player = scenario_players[active_player.player_index]
		else:
			active_player = scenario_players[0]
			if(not start_round_active and not battle_phase_active):
				SignalBus.call_deferred("emit_signal", "init_battle_phase")
			elif( battle_phase_active):
				SignalBus.call_deferred("emit_signal", "init_start_round")
				
		SignalBus.call_deferred("emit_signal", "next_active_player")
		SignalBus.call_deferred("emit_signal", "update_player_action_points_label", active_player)

func set_player_nation(player_index : int, nation_name : String):
	scenario_players[player_index].set_nation(nation_name)
	

func exist_player(player_index : int) -> bool:
	for player in self.scenario_players:
		if player.player_index == player_index:
			return true
	return false
	
func add_player(player_index : int):
	var new_player : Player = Player.new()
	new_player.set_player_index(player_index)
	
	scenario_players.append(new_player)

func remove_player(player_index : int):
	scenario_players.remove_at(player_index)
	
func player_indexfunc():
	return active_player.player_index
	
func region_with_owner():
	var regions_with_owner : Dictionary
	var all_regions : Array = scenario_region_graph.region_array
	for region in all_regions:
		regions_with_owner[region.region_name] = region.region_owner_index
	return regions_with_owner

func exist_possible_battle():
	for region in scenario_region_graph.region_array:
		for neighbour in region.neighbours:
			if region.holder != neighbour.holder \
				and region.holder != "" \
				and neighbour.holder != "" \
				and region.count_army() > 1:
				return true
	return false
