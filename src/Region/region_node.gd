extends Node

class_name RegionNode

@onready var region_name : String
@onready var resource : String
@onready var area : String
@onready var building_slots : Array[String]
@onready var buildings : Array[String]
@onready var region_army : Dictionary
@onready var neighbours : Array[RegionNode]
@onready var holder : String
@onready var resource_factor : int
@onready var defense_factor : int
@onready var travel_cost : int
@onready var curse : int 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
