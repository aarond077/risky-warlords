extends Node

class_name RegionGraph

var root : RegionNode
var region_array : Array[RegionNode] #will get deleted after region graph is finished


func load_resources_to_array():
	var map_resources = DataFileManager.import_file("res://data/Maps/" + 
		ScenarioDataManager.scenario_map_name + "/" + 
		ScenarioDataManager.scenario_map_name + "Resources.txt")
	for region in self.region_array:
		if map_resources[region.region_name][0] != "Null":
			region.resource = map_resources[region.region_name][0]
			region.resource_factor = int(map_resources[region.region_name][1])

func load_regions_to_array():
	var map_regions = DataFileManager.import_file("res://data/Maps/" + 
		ScenarioDataManager.scenario_map_name + "/" + 
		ScenarioDataManager.scenario_map_name + "Indexes.txt")
	for region in map_regions:
		var new_region : RegionNode = RegionNode.new()
		new_region.region_name = region
		self.region_array.append(new_region)

func get_region_node(region_name : String):
	pass
