extends PanelContainer


@onready var action_points_label : Label = $VBoxContainer/GridContainer2/MarginActionPointsInput/ActionPointsInputLabel
@onready var create_building_menu_button = $VBoxContainer/MarginContainer2/GridContainer/GebaeudeErrichten
@onready var add_resource_menu_button =  $VBoxContainer/MarginContainer2/GridContainer/RessourcenSammeln
@onready var research_menu_button = $VBoxContainer/MarginContainer2/GridContainer/Forschen

# Called when the node enters the scene tree for the first time.
func _ready():
	add_resource_menu_button.get_popup().id_pressed.connect(_on_resource_menu_pressed)
	research_menu_button.get_popup().id_pressed.connect(_on_research_menu_pressed)
	create_building_menu_button.get_popup().id_pressed.connect(_on_building_menu_pressed)
	SignalBus.call_deferred("connect", "update_player_action_points_label", on_update_player_action_points_label)
	SignalBus.call_deferred("connect", "next_active_player", on_next_active_player)

func set_action_points_label(action_points : int) -> void:
	action_points_label.text = str(action_points)

			
func building_is_creatable(region : RegionNode, player : Player) -> bool:
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
		
	
func building_is_removable(region : RegionNode, player : Player) -> bool:
	if(player.action_points > 0 and region.building != "Festung"):
		return true
	return false
	
func apply_building_costs(building : String, player : Player) -> bool:
	if building == "Heiligtum - 4S 4E | 2AP":
		if player.resources["Stone"] >= 4 and player.resources["Iron"] >= 4: 
			player.reduce_resource_stone(4)
			player.reduce_resource_iron(4)
			return true
	elif building == "Wachturm - 5H | 2AP":
		if player.resources["Wood"] >= 5:
			player.reduce_resource_wood(5)
			return true
	elif building == "Forschungsgebäude - 10E | 2AP":
		if player.resources["Iron"] >= 10:
			player.reduce_resource_iron(10)
			return true
	elif building == "Marktplatz - 2H | 2S | 2E | 2AP":
		if player.resources["Wood"] >= 2 \
			and player.resources["Iron"] >= 2 \
			and player.resources["Stone"] >= 2:
				player.reduce_resource_iron(2)
				player.reduce_resource_stone(2)
				player.reduce_resource_wood(2)
				return true
	elif building == "Ressourcengebäude - 3 H/S/E | 2AP":
		if ScenarioDataManager.active_region.resource == "Wood":
			if player.resources["Wood"] >= 3:
				player.reduce_resource_wood(3)
				return true
		elif ScenarioDataManager.active_region.resource == "Iron":
			if player.resources["Iron"] >= 3:
				player.reduce_resource_iron(3)
				return true
		elif ScenarioDataManager.active_region.resource == "Stone":
			if player.resources["Stone"] >= 3:
				player.reduce_resource_stone(3)
				return true
	return false

		
func add_removed_building_resources(building : String, player : Player) -> void:
	if building == "Heiligtum":
			player.add_resource_stone(4)
			player.add_resource_iron(4)
	elif building == "Wachturm":
			player.add_resource_wood(5)
	elif building == "Forschungsgebäude":
			player.add_resource_iron(10)
	elif building == "Mine":
			player.add_resource_iron(3)
	elif building == "Marktplatz":
		player.add_resource_iron(2)
		player.add_resource_stone(2)
		player.add_resource_wood(2)
	elif building == "Holzfällerhütte":
			player.add_resource_wood(3)
	elif building == "Steinbruch":
			player.add_resource_stone(3)
	
func on_update_player_action_points_label(player : Player) -> void:
	set_action_points_label(player.action_points)
	
func on_next_active_player(player : Player) -> void:
	set_action_points_label(player.action_points)
	
func _on_resource_menu_pressed(id : int):
	var active_player : Player = ScenarioDataManager.active_player
	if active_player.action_points > 1:
		if(id == 0):
			active_player.resources["Stone"] += 3
			AudioManager.play_stone()
		elif(id == 1):
			active_player.resources["Wood"] += 3
			AudioManager.play_wood()
		elif(id == 2):
			active_player.resources["Iron"] += 3
			AudioManager.play_iron()
		elif(id == 3):
			active_player.resources["Food"] += 3
		active_player.action_points -= 2
		SignalBus.emit_signal("update_player_action_points_label", active_player)
		SignalBus.emit_signal("update_player_resources_label", active_player)

func _on_building_menu_pressed(id: int):
	var building_name = create_building_menu_button.get_popup().get_item_text(id)
	var active_region : RegionNode = ScenarioDataManager.active_region
	var active_player : Player = ScenarioDataManager.active_player
	if active_region != null:
		if building_is_creatable(active_region, active_player) \
		and region_is_accessable(active_region, active_player) \
		and apply_building_costs(building_name, active_player) \
		and (not active_player.has_research_center \
			or building_name != "Forschungsgebäude - 10E | 2AP" )\
		and (active_player.sanctuary_bonus < 2 \
			or  building_name != "Heiligtum - 4S 4E | 2AP") \
		and (not active_player.has_marketplace \
			or building_name != "Marktplatz - 2H | 2S | 2E | 2AP"):
			
			SignalBus.call_deferred("emit_signal", "create_building", building_name)
			active_player.action_points -= 2
			SignalBus.call_deferred(
			"emit_signal",
			"update_player_action_points_label",
			active_player
			)
			SignalBus.call_deferred("emit_signal", "update_player_resources_label", active_player)
			
			if(building_name == "Heiligtum - 4S 4E | 2AP"):
				active_player.sanctuary_bonus += 2
			elif(building_name == "Forschungsgebäude - 10E | 2AP"):
				active_player.has_research_center = true
			elif(building_name == "Marktplatz - 3H | 3S | 3E | 2AP"):
				active_player.has_marketplace = true
			AudioManager.play_construction()
		

func _on_building_remove_button_pressed() -> void:
	AudioManager.play_select()
	var active_player : Player = ScenarioDataManager.active_player
	var active_region : RegionNode = ScenarioDataManager.active_region
	
	if active_region != null:
	
		if (building_is_removable(active_region, active_player) and region_is_accessable(active_region, active_player)):#active_player.player_index == active_region.region_owner_index):
			if(active_region.building == "Heiligtum"):
				active_player.sanctuary_bonus = 0
			elif(active_region.building == "Forschungscenter"):
				active_player.has_research_center = false
				active_player.archer_upgrade = false
				active_player.tank_upgrade = false
			elif(active_region.building == "Marktplatz"):
				active_player.has_marketplace = false
			
			SignalBus.call_deferred(
				"emit_signal", 
				"remove_sprite", 
				active_region.building,
				active_region.region_name
				)
			
		
			self.add_removed_building_resources(
				active_region.building,
				active_player
				)
		
			SignalBus.call_deferred(
				"emit_signal",
				"update_player_resources_label",
				active_player
				)
			
			active_region.building = ""
			active_player.action_points -= 1

func _on_research_menu_pressed(id: int):

	var research_name : String = research_menu_button.get_popup().get_text(id)
	var active_player : Player = ScenarioDataManager.active_player
	
	if(active_player.action_points > 0 and active_player.has_research_center):
		if(id == 0):
			pass
		elif(id == 1 and not active_player.archer_upgrade):
			active_player.archer_upgrade = true
			active_player.action_points -= 1
		elif(id == 2 and not active_player.tank_upgrade):
			active_player.tank_upgrade = true
			active_player.action_points -= 1
		elif(id == 3) and active_player.sanctuary_bonus == 2: 
			active_player.sanctuary_bonus += 1
			active_player.action_points -= 1
	
	

func _on_move_army_button_pressed() -> void:
	AudioManager.play_select()
	if(ScenarioDataManager.active_region != null):
		if(ScenarioDataManager.active_player.action_points > 0): #cost of traveling is 1 by now
			var army : Dictionary = ScenarioDataManager.active_region.region_army
			print(army["Warriors"])

		var active_player : Player = ScenarioDataManager.active_player
		var active_region : RegionNode = ScenarioDataManager.active_region
	
		if(ScenarioDataManager.active_player.action_points > 0 \
			and region_is_accessable(active_region, active_player)): #cost of traveling is 1 by now
			ScenarioDataManager.active_player.army_movement = not ScenarioDataManager.active_player.army_movement

func region_is_accessable(region : RegionNode, player : Player) -> bool:
	var active_player_name : String = "Player " + str(player.player_index)
	
	if  active_player_name == region.holder:
		return true
	print("not your region")
	return false


func _on_gebaeude_errichten_pressed():
	AudioManager.play_select()


func _on_ressourcen_sammeln_pressed():
	AudioManager.play_select()


func _on_forschen_pressed():
	AudioManager.play_select()
