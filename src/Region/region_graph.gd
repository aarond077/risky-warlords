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

#diese methode erzeugt den vollständigen RegionGraph
func create_region_graph_from_file(map_name: String):
	var region_graph = RegionGraph.new()
	
	load_regions_to_array()
	var region_graph_dict_with_names = create_dict_with_map_names(map_name)
	for region in region_graph_dict_with_names:
		add_neighbours_to_region(region, region_graph_dict_with_names)
	region_graph.root = region_array[0]
	
#diese methode füllt das Attribut neighbours aller RegionNodes
func add_neighbours_to_region(region_name: String, region_graph_dict: Dictionary):
	var neigbour_array = region_graph_dict[region_name]
	var real_neighbour_array : Array[RegionNode]
	
	var region = return_region_node_from_name(region_name)
	
	for neighbour in neigbour_array:
		real_neighbour_array.append(return_region_node_from_name(neighbour))
	region.neighbours = real_neighbour_array
	
#diese methode findet für den namen eines RegionNodes 
#den zugehörigen RegionNode und gibt ihn zurück
func return_region_node_from_name(region_name: String):
	for region in region_array:
		if region.region_name == region_name:
			return region


func load_regions_to_array():
	var map_regions = DataFileManager.import_file("res://data/Maps/" + 
		ScenarioDataManager.scenario_map_name + "/" + 
		ScenarioDataManager.scenario_map_name + "Indexes.txt")
	for region in map_regions:
		var new_region : RegionNode = RegionNode.new()
		new_region.region_name = region
		self.region_array.append(new_region)

		# Beispiel: Absoluter Pfad eines Nodes
		var node = new_region
		var relative_path = node.get_path_to(node.get_parent())
		print(relative_path)


#diese methode erstellt eine adjazenzliste in einem dict
#mit den namen der regionen

func create_dict_with_map_names(map_name: String) -> Dictionary:
		var areas = {}
		# Öffne die Datei
		if OK == OK:
			var region_graph_dict = DataFileManager.import_file(
			"res://data/Maps/" + map_name + "/" + map_name + "RegionGraph.txt")
			var index_dict = DataFileManager.import_file(
			"res://data/Maps/" + map_name + "/" + map_name + "Indexes.txt")
			for region in region_graph_dict:
				var node = turn_index_to_map_name(region, index_dict)
				var adjacent_nodes = turn_index_to_map_name(region_graph_dict[region], index_dict)
				areas[node] = adjacent_nodes
				#forest.add_area(node, adjacent_nodes)
		return areas
	
	#Methode, die den index zum Mapnamen umwandelt
func turn_index_to_map_name(index, index_dict: Dictionary):
		if type_string(typeof(index)) != "Array":
			var stringConverted = int(index)
			var keys = index_dict.keys()
			return keys[stringConverted]
			
		elif type_string(typeof(index)) == "Array":
			var new_array = Array()
			for zaehler in range(len(index)):
				var keys = index_dict.keys()
				new_array.append(keys[index[zaehler]])
			return new_array

	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_region_node(region_name : String):
	pass
