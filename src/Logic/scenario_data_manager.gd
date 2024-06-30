extends Node2D

@export var scenario_map_name : String
@export var scenario_players : Array[Player]
@export var scenario_region_graph : RegionGraph
@export var maps : Array[String]

@onready var active_region : RegionNode
@onready var active_region_color : String
@onready var active_player : Player
@onready var building_coordinates : Dictionary

@onready var capitals : Array


# Called when the node enters the scene tree for the first time.
func _ready():
	self.scenario_region_graph = RegionGraph.new()
	
func update_player_action_points():
	for player in self.scenario_players:
		player.update_action_points()
	
func update_player_resources():
	for player in self.scenario_players:
		player.update_resources()

func update_player_army(warriors : int, archers : int, tanks : int):
	for player in self.scenario_players:
		player.update_army(warriors, archers, tanks)

func add_army_to_region(
	region : RegionNode,
	warriors : int,
	archers : int,
	tanks : int ) -> void:
	region.update_army(warriors, archers, tanks)
	

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func store_start_scenario__properties(scenario_map_name : String,
							scenario_players : Array[Player], 
							scenario_region_graph : RegionGraph):
	self.scenario_map_name = scenario_map_name
	self.scenario_players = scenario_players
	self.scenario_region_graph = scenario_region_graph
	
func add_region_owner(region_name : String, player_index : int):
	for region in self.scenario_region_graph.region_array:
		if region.region_name == region_name:
			region.region_owner_index = player_index
	

	
# sets the capitals according to the map capitals
func set_scenario_players_capitals(capitals) -> void:
	var rand_capital_index : int
	for player in self.scenario_players:
		player.regions = RegionGraph.new()

		rand_capital_index = randi_range(0, capitals.size()-1)
		while(player.capital == capitals[rand_capital_index]):
			rand_capital_index = randi_range(0, capitals.size()-1)
		player.capital = capitals[rand_capital_index]
		player.add_region_to_array(player.capital)
		
		add_region_owner(player.capital, player.player_index)
		
		capitals.remove_at(rand_capital_index)
	
func set_start_scenario_active_player():
	self.active_player = scenario_players[0]
	SignalBus.call_deferred("emit_signal", "next_active_player")
	
	

func set_next_active_player():
	if(active_player.player_index < scenario_players.size()):
		active_player = scenario_players[active_player.player_index]
	else:
		active_player = scenario_players[0]
	SignalBus.call_deferred("emit_signal", "next_active_player")

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

