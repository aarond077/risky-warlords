extends Node2D

@onready var player_timer : Timer = $"../CanvasLayer/ScenarioOverlay/PanelContainerInfo/PlayerTimer"
@onready var buildings : Node = $Buildings
@onready var army_count : Node = $ArmyCount

func _ready():
	SignalBus.call_deferred("connect", "create_building", on_create_building)
	SignalBus.call_deferred("connect", "draw_capitals_fortress", on_draw_capitals_fortress)
	SignalBus.call_deferred("connect", "set_political_view", on_set_political_view)
	SignalBus.call_deferred("connect", "set_physical_view", on_set_physical_view)
	SignalBus.call_deferred("connect", "show_army_counter_labels", on_show_army_counter_labels)
	SignalBus.call_deferred("connect", "hide_army_counter_labels", on_hide_army_counter_labels)
	SignalBus.call_deferred("connect", "update_army_counter_labels", on_update_army_counter_labels)
	SignalBus.call_deferred("connect", "create_army_counter_labels", on_create_army_counter_labels)

func on_show_army_counter_labels():
	for region in ScenarioDataManager.scenario_region_graph.region_array:
		var region_army_count : ArmyCountLabel = army_count.find_army_count_label_by_name(region.region_name)
		if region.count_army() > 0:
			region_army_count.visible = true
		else:
			region_army_count.visible = false
		


func on_hide_army_counter_labels():
	for army_count_label in army_count.get_children():
		army_count_label.visible = false


func on_update_army_counter_labels():
		for region in ScenarioDataManager.scenario_region_graph.region_array: 
			var region_army_count : ArmyCountLabel = army_count.find_army_count_label_by_name(region.region_name)
			var army_count : int = region.count_army()
			region_army_count.text = str(army_count)
			if army_count > 0:
				region_army_count.visible = true
			else:
				region_army_count.visible = false
			
			
			
			
func on_create_army_counter_labels():
	for region in ScenarioDataManager.scenario_region_graph.region_array:
			var army_count_label : ArmyCountLabel = ArmyCountLabel.new()
			var position_x = ScenarioDataManager.building_coordinates[region.region_name][0]
			var position_y = ScenarioDataManager.building_coordinates[region.region_name][1]
			army_count_label.region_name = region.region_name
			army_count_label.position.x = position_x
			army_count_label.position.y = position_y
			
			army_count_label.text = str(region.count_army())
			
			if region.count_army() == 0:
				army_count_label.visible = false
			
			
			
			army_count.add_child(army_count_label)
			
			
func on_set_physical_view():
	buildings.visible = true

func on_set_political_view():
	buildings.visible = false

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
	
