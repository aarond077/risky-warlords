extends Node2D

@export var scenario_map_name : String
@export var scenario_players : Array[Player]
@export var scenario_region_graph : RegionGraph
@export var maps : Array[String]


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

