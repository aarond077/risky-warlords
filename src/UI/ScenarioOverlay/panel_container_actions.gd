extends PanelContainer


@onready var action_points_label : Label = $VBoxContainer/GridContainer2/MarginActionPointsInput/ActionPointsInputLabel
@onready var create_building_menu_button = $VBoxContainer/MarginContainer2/GridContainer/GebaeudeErrichten
# Called when the node enters the scene tree for the first time.
func _ready():
	create_building_menu_button.get_popup().id_pressed.connect(_on_item_menu_pressed)
	SignalBus.call_deferred("connect", "update_player_action_points_label", on_update_player_action_points_label)
	SignalBus.call_deferred("connect", "next_active_player", on_next_active_player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_action_points_label(action_points : int) -> void:
	action_points_label.text = str(action_points)
	
func on_update_player_action_points_label(player : Player) -> void:
	set_action_points_label(player.action_points)
	
func on_next_active_player(player : Player) -> void:
	set_action_points_label(player.action_points)

func _on_item_menu_pressed(id: int):
	var building_name = create_building_menu_button.get_popup().get_item_text(id)
	var active_region : RegionNode = ScenarioDataManager.active_region
	var active_player : Player = ScenarioDataManager.active_player
	if check_building_action(active_region, active_player):
		SignalBus.call_deferred("emit_signal", "create_building", building_name)
		active_player.action_points -= 2
		SignalBus.call_deferred(
		"emit_signal",
		"update_player_action_points_label",
		active_player
		)
		
func check_building_action(region : RegionNode, player : Player) -> bool:
	'''Checks if region allows buildings in general. Also checks if the player
	that wants to create the building has enough action points available. 
	It is not allowed to create multiple buildings in one region.
	
	params:
	region : RegionNode
	player : Player  
	returns: bool (building is creatable or not)'''
	
	return ScenarioDataManager.building_coordinates[region.region_name][0] != 0 \
		and ScenarioDataManager.building_coordinates[region.region_name][1] != 0 \
		and region.building == "" \
		and player.action_points >= 2

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
		
		active_region.building = ""





func _on_move_army_button_pressed():
	var army : Dictionary = ScenarioDataManager.active_region.region_army
	print(army["Warriors"])
