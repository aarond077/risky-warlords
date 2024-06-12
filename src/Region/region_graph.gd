extends Node

class_name RegionGraph

@onready var root : RegionNode
@onready var region_array : Array[RegionNode] #will get deleted after region graph is finished

# Klasse für die Gebiete
class AreaNode:
	var name: String
	var adjacent_areas: Array

	func _init(name: String, adjacent_areas: Array):
		self.name = name
		self.adjacent_areas = adjacent_areas
		

# Hauptklasse Forest
class Forest:
	var areas: Dictionary

	# Initialisierung der Klasse
	func _init():
		areas = {}

	# Methode zum Hinzufügen eines neuen Gebiets zur Karte
	func add_area(name: String, adjacent_areas: Array):
		var new_area = AreaNode.new(name, adjacent_areas)
		areas[name] = new_area
		
	# Methode zum Abrufen der angrenzenden Gebiete für ein bestimmtes Gebiet
	func get_adjacent_areas(name: String) -> Array:
		if areas.has(name):
			return areas[name].adjacent_areas
		else:
			return []
		
	# Methode zum Lesen einer Adjazenzliste aus einer Textdatei und Erstellen des Forests
	func create_forest(filename: String, map_name: String) -> Forest:
		var forest = Forest.new()
		# Öffne die Datei
		if OK == OK:
			var index_dict = import_file(
			"res://data/Maps/" + map_name + "/" + map_name + "Indexes.txt")
		
			var region_graph_dict = import_file(
			"res://data/Maps/" + map_name + "/" + map_name + "RegionGraph.txt")
			
			for region in region_graph_dict:
				var node = turn_index_to_map_name(region[0], index_dict)
				var adjacent_nodes = turn_index_to_map_name(region[1], index_dict)
				
				forest.add_area(node, adjacent_nodes)
		return forest
	
	#access file function
	func import_file(filepath : String):
		var file = FileAccess.open(filepath, FileAccess.READ)
		if file != null:
			return JSON.parse_string(file.get_as_text().replace("_", " "))
		else:
			print("Failed to open file:" + filepath)
			return null	
	
	#Methode, die den index zum Mapnamen umwandelt
	func turn_index_to_map_name(index, index_dict: Dictionary):
		if typeof(index) == TYPE_INT:
			return index_dict[index]
			
		elif typeof(index) == TYPE_ARRAY:
			var new_array = Array()
			for number in index:
				new_array.append(index_dict[number])
			return new_array
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_region_node(region_name : String):
	pass
	
func add_region_node(new_node : RegionNode, neighbour_node : String):
	pass
	
func remove_region_node(region_name : String):
	pass

func generate_region_graph_from_file(filename : String):
	pass

func generate_region_graph_from_capital(capital : String, map_graph : RegionGraph):
	pass
	
func find_shortest_route(start_node : RegionNode, end_node : RegionNode):
	pass

func is_empty():
	pass

func size():
	pass

