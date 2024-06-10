extends OptionButton

@onready var maps_capitals : Dictionary 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_selected(index):
	maps_capitals = DataFileManager.import_file("res://data/Maps/capitals.txt")
	ScenarioDataManager.building_coordinates = DataFileManager.import_file("res://data/Maps/" + self.text
		+ "/" + self.text + "BuildingSlots.txt")
	ScenarioDataManager.scenario_map_name = self.text
	ScenarioDataManager.capitals = maps_capitals[self.text]
