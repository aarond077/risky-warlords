extends Node2D

@onready var player_timer : Timer = $"../CanvasLayer/ScenarioOverlay/PanelContainerInfo/PlayerTimer"
@onready var buildings : Node = $Buildings
@onready var army_count : Node = $ArmyCount
@onready var banners : Node = $Banners
@onready var sea_connections : Sprite2D = $SeaConnections
@onready var region_areas : Node = $Regions

func _ready():
	SignalBus.call_deferred("connect", "create_building", on_create_building)
	SignalBus.call_deferred("connect", "draw_capitals_fortress", on_draw_capitals_fortress)
	SignalBus.call_deferred("connect", "set_political_view", on_set_political_view)
	SignalBus.call_deferred("connect", "set_physical_view", on_set_physical_view)
	SignalBus.call_deferred("connect", "show_army_count_labels", on_show_army_count_labels)
	SignalBus.call_deferred("connect", "hide_army_count_labels", on_hide_army_count_labels)
	SignalBus.call_deferred("connect", "update_army_count_labels", on_update_army_count_labels)
	SignalBus.call_deferred("connect", "create_army_count_labels", on_create_army_count_labels)
	SignalBus.call_deferred("connect", "update_banners", on_update_banners)
	SignalBus.call_deferred("connect", "player_defeated", on_player_defeated)
	SignalBus.connect("load_sea_connections", on_load_sea_connections)
	
func draw_political_view():
	for region_area in region_areas.get_children():
		region_area.draw_region_outlines()
		var region_node : RegionNode = ScenarioDataManager.find_region_in_array(
				region_area.region_name)
		for child in region_area.get_children():
			if child is Polygon2D:
				if region_node.holder == "":
						child.color = Color(0.70,0.70,0.70,0.9)
				else:
					child.color = ScenarioDataManager.map_index_to_color(region_node.region_owner_index)


func on_player_defeated(player : Player):
	for region in player.regions.region_array:
		var region_scenario_graph : RegionNode = ScenarioDataManager.find_region_in_array(region.region_name)
		region_scenario_graph.reset_army()
		region_scenario_graph.holder = ""
		region_scenario_graph.region_owner_index = 0
		SignalBus.emit_signal("remove_sprite", "Banner" + player.nation, region_scenario_graph.region_name)
		SignalBus.emit_signal("remove_sprite", region_scenario_graph.building, region_scenario_graph.region_name)
		
	

func on_load_sea_connections(map_name : String):
	sea_connections.texture = load("res://assets/Maps/" + map_name + "/" + map_name + "Seeverbindungen.png")

func on_update_banners(target_region : RegionNode, player : Player):
	var banner_position = Vector2(
				ScenarioDataManager.banner_coordinates[target_region.region_name][0],
				ScenarioDataManager.banner_coordinates[target_region.region_name][1]
			)
	if target_region.holder != "" and target_region.holder != "Player " + str(player.player_index):
		var old_banner_name : String = "Banner" + ScenarioDataManager.find_player_by_holder(target_region.holder).nation
		SignalBus.emit_signal("remove_sprite", old_banner_name, target_region.region_name)
	var new_banner : RemovableSprite = BannerFactory.create_banner(banner_position, target_region.region_name, player.nation)
	banners.add_child(new_banner)

func on_update_political_view() -> void:
	if ScenarioDataManager.political_view_active:
		draw_political_view()

func on_set_political_view() -> void:
	ScenarioDataManager.political_view_active = true
	draw_political_view()
	buildings.visible = false
	banners.visible = false
			
func on_set_physical_view():
	buildings.visible = true
	banners.visible = true

func on_show_army_count_labels():
	for region in ScenarioDataManager.scenario_region_graph.region_array:
		var region_army_count : ArmyCountLabel = army_count.find_army_count_label_by_name(region.region_name)
		if region.count_army() > 0:
			region_army_count.visible = true
		else:
			region_army_count.visible = false
		


func on_hide_army_count_labels():
	for army_count_label in army_count.get_children():
		army_count_label.visible = false


func on_update_army_count_labels():
		for region in ScenarioDataManager.scenario_region_graph.region_array: 
			var region_army_count : ArmyCountLabel = army_count.find_army_count_label_by_name(region.region_name)
			var army_count : int = region.count_army()
			region_army_count.text = str(army_count)
			if army_count > 0 and ScenarioDataManager.political_view_active:
				region_army_count.visible = true
			else:
				region_army_count.visible = false
			
			
			
			
func on_create_army_count_labels():
	for region in ScenarioDataManager.scenario_region_graph.region_array:
			var army_count_label : ArmyCountLabel = ArmyCountLabel.new()
			var position_x = ScenarioDataManager.banner_coordinates[region.region_name][0]
			var position_y = ScenarioDataManager.banner_coordinates[region.region_name][1]
			#army_count_label.region_name = region.region_name
			army_count_label.position.x = position_x
			army_count_label.position.y = position_y
			
			army_count_label.text = str(region.count_army())
			army_count_label.theme = load("res://assets/UI/Themes/army_count.tres")
			army_count_label.name = region.region_name
			army_count_label.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			army_count_label.custom_minimum_size.x = 35
			army_count_label.custom_minimum_size.y = 23
			army_count_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			army_count_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			
			
			#if region.count_army() == 0:
			army_count_label.visible = false
			
			
			army_count.add_child(army_count_label)
			

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
	
