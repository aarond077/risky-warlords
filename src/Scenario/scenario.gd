extends Node2D

@onready var player_timer : Timer = $"../CanvasLayer/ScenarioOverlay/PanelContainerInfo/PlayerTimer"
@onready var buildings : Node = $Buildings
@onready var players : Node = $Players

func _ready():
	SignalBus.call_deferred("connect", "create_building", on_create_building)
	SignalBus.call_deferred("connect", "draw_capitals_fortress", on_draw_capitals_fortress)
		

func on_draw_capitals_fortress():
	for player in ScenarioDataManager.scenario_players:
		var position = Vector2(
				ScenarioDataManager.building_coordinates[player.capital][0],
				ScenarioDataManager.building_coordinates[player.capital][1]
			)
		var fortress : RemovableSprite = BuildingFactory.create_fortress(player.nation, position, player.capital)
		buildings.add_child(fortress)
		
	


func _on_player_timer_timeout():
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
	
	if new_building != null:
		active_region.building = new_building.sprite_name
		buildings.add_child(new_building)
	
