extends Node2D

@export var scenario_map_name : String
@export var scenario_players : Array[Player]
@export var scenario_region_graph : RegionGraph
@export var maps : Array[String]

@onready var active_region : RegionNode
@onready var active_region_color : String
@onready var active_player : Player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func store_start_scenario__properties(scenario_map_name : String,
							scenario_players : Array[Player], 
							scenario_region_graph : RegionGraph):
	self.scenario_map_name = scenario_map_name
	self.scenario_players = scenario_players
	self.scenario_region_graph = scenario_region_graph
	
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

