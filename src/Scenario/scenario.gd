extends Node2D

@onready var player_timer : Timer = $"../CanvasLayer/ScenarioOverlay/PanelContainerTimer/PlayerTimer"
@onready var buildings : Node = $Buildings
@onready var players : Node = $Players

func _ready():
	SignalBus.call_deferred("connect", "create_building", on_create_building)
	ScenarioDataManager.set_scenario_players_capitals(
		ScenarioDataManager.capitals
	)
	ScenarioDataManager.scenario_region_graph.load_regions_to_array()
	ScenarioDataManager.scenario_region_graph.load_resources_to_array()
	draw_capitals_fortress()
		

func draw_capitals_fortress():
	for player in ScenarioDataManager.scenario_players:
		var position = Vector2(
				ScenarioDataManager.building_coordinates[player.capital][0],
				ScenarioDataManager.building_coordinates[player.capital][1]
			)
		var fortress : RemovableSprite = BuildingFactory.create_fortress(player.nation, position, player.capital)
		buildings.add_child(fortress)
		
	


func _on_player_timer_timeout():
	#draw_capitals_fortress()
	#for region in ScenarioDataManager.building_coordinates:
	#	print(region)
	#	print(typeof(region))
	#	for player in ScenarioDataManager.scenario_players:
	#		if(player.capital == region):
	#			print("make sensi")
	
	print(ScenarioDataManager.active_player.capital)
	ScenarioDataManager.set_next_active_player()
	player_timer.start()

func on_create_building(building_name):
	var active_region : RegionNode = ScenarioDataManager.active_region
	var active_player_nation = ScenarioDataManager.active_player.nation
	var building_position : Vector2 = Vector2(
		ScenarioDataManager.building_coordinates[active_region.region_name][0],
		ScenarioDataManager.building_coordinates[active_region.region_name][1]
	)
	
	var new_building : RemovableSprite = BuildingFactory.create_building(
		building_name,
		active_player_nation,
		building_position,
		active_region.region_name
	)
	active_region.building = new_building.sprite_name
	buildings.add_child(new_building)
	
