extends Node

class_name RegionGraph

@onready var root : RegionNode

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

func generate_region_graph_from_capital(capital : String):
	pass

func is_empty():
	pass
	
	


func size():
	pass
