extends PanelContainer



@onready var create_building_menu_button = $VBoxContainer/MarginContainer2/GridContainer/GebaeudeErrichten
# Called when the node enters the scene tree for the first time.
func _ready():
	create_building_menu_button.get_popup().id_pressed.connect(_on_item_menu_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_item_menu_pressed(id: int):
	var building_name = create_building_menu_button.get_popup().get_item_text(id)
	var active_region : RegionNode = ScenarioDataManager.active_region
	if ScenarioDataManager.building_coordinates[active_region.region_name][0] != 0 \
		and ScenarioDataManager.building_coordinates[active_region.region_name][1] != 0 \
		and active_region.building == "":
		SignalBus.call_deferred("emit_signal", "create_building", building_name)
	
	


func _on_building_remove_button_pressed():
	var active_player : Player = ScenarioDataManager.active_player
	var active_region : RegionNode = ScenarioDataManager.active_region
	
	if ( true):#active_player.player_index == active_region.region_owner_index):
		SignalBus.call_deferred(
			"emit_signal", 
			"remove_sprite", 
			active_region.building,
			active_region.region_name
			)
			
		var building : String = active_region.building
		if building == "Festung":
			active_player.add_resource_stone(5)
		if building == "Heiligtum":
			active_player.add_resource_stone(4)
			active_player.add_resource_iron(4)
		if building == "Wachturm":
			active_player.add_resource_wood(5)
		if building == "Forschungsgebäude":
			active_player.add_resource_iron(10)
		if building == "Mine":
			active_player.add_resource_iron(3)
		if building == "Holzfällerhütte":
			active_player.add_resource_wood(3)
		if building == "Steinbruch":
			active_player.add_resource_stone(3)
		
		SignalBus.call_deferred("emit_signal", "update_player_resources_label", active_player)
		active_region.building = ""
