extends PanelContainer

@onready var region_label = $VBoxContainer/GridContainer/MarginRegionNameInput/RegionNameInputLabel
@onready var region_resource_label = $VBoxContainer/GridContainer/MarginRegionResourceInput/RegionResourceInputLabel
@onready var region_army_label = $VBoxContainer/GridContainer/MarginRegionArmyInput/RegionArmyInputLabel
@onready var region_building_label = $VBoxContainer/GridContainer/MarginRegionBuildingInput/RegionBuildingInputLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "region_clicked", on_region_clicked)
	SignalBus.call_deferred("connect", "create_building", on_create_building)
	SignalBus.call_deferred("connect", "remove_sprite", on_remove_sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func update_region(region_name : String) -> void:
	var active_region : RegionNode
	active_region = ScenarioDataManager.find_active_region_in_array(region_name)
	update_region_name(active_region)
	update_region_describtion(active_region)
	update_region_resource(active_region)
	update_region_building(active_region.building)
	update_region_army(active_region.region_army)

func update_region_army(region_army : Dictionary):
	region_army_label.text = str(
		region_army["Warriors"]) + \
		"K | " + \
		str(region_army["Archers"]) + \
		"B | " + \
		str(region_army["Tanks"]) + \
		"T" 
	
func update_region_name(region_node : RegionNode):
	region_label.text = region_node.region_name

func update_region_describtion(region_node : RegionNode):
	pass

func update_region_building(building_name):
	region_building_label.text = building_name

func get_resource_text(region_node : RegionNode):
	var resource_name_german : String = ""
	if(region_node.resource == "Wood"):
		resource_name_german = "Holz"
	elif(region_node.resource == "Iron"):
		resource_name_german = "Eisen"
	elif(region_node.resource == "Stone"):
		resource_name_german = "Stein"
	return str(region_node.resource_factor) + "x" + " " \
	 		+ resource_name_german
	
	
func update_region_resource(region_node : RegionNode):
	if region_node.resource_factor > 0:
		region_resource_label.text =  get_resource_text(region_node)
	else:
		region_resource_label.text = ""

func on_region_clicked(region_name : String) -> void:
	update_region(region_name)

func on_create_building(building_name):
	update_region_building(ScenarioDataManager.active_region.building)

func on_remove_sprite(sprite_name : String, region_name : String):
	update_region(region_name)
