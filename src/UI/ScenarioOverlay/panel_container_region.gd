extends PanelContainer

@onready var region_label =$VBoxContainer/GridContainer/MarginRegionNameInput/RegionNameInputLabel
@onready var region_resource_label = $VBoxContainer/GridContainer/MarginRegionResourcesInput/GebietsressourcenInputLabel
@onready var region_army_label = $VBoxContainer/GridContainer/MarginRegionArmyInput/ArmyInputLabel
@onready var region_building_label = $VBoxContainer/GridContainer/MarginRegionBuildingInput/BuildingInputLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "region_clicked", on_region_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_region_clicked(region_name : String) -> void:
	update_region(region_name)
	
func update_region(region_name : String) -> void:
	update_region_name(region_name)
	update_region_describtion()
	update_region_resource()
	
func update_region_name(region_name : String):
	region_label.text = region_name

func update_region_describtion():
	pass
	
func update_region_resource():
	pass
	
func get_region_node(region_name : String):
	pass
		

