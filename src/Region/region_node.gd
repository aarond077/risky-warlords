extends Node

class_name RegionNode

@onready var region_name : String
@onready var building_slots : Array[String]
@onready var building : String



@onready var resource_factor : int
@onready var defense_factor : int
@onready var travel_cost : int
@onready var curse : int 
@onready var building_coordinates : Vector2
@onready var region_owner_index : int = 0

var holder : String
var resource : String
var neighbours : Array[RegionNode]
var region_army : Dictionary = {"Warriors" : 0, "Archers" : 0, "Tanks" : 0}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func army_ready_to_attack() -> bool:
	if(region_army["Warriors"] + \
		region_army["Archers"] + \
		region_army["Tanks"] >= 2):
			return true
	else: 
		return false

func army_is_empty() -> bool:
	if(count_army() > 0):
			return false
	else: 
		return true
		
func count_army() -> int:
	return region_army["Warriors"] + \
		region_army["Archers"] + \
		region_army["Tanks"]

func increase_army(warriors : int, archers : int, tanks : int):
	region_army["Warriors"] += warriors
	region_army["Archers"] += archers
	region_army["Tanks"] += tanks

func decrease_army(warriors : int, archers : int, tanks : int):
	region_army["Warriors"] -= warriors
	region_army["Archers"] -= archers
	region_army["Tanks"] -= tanks
	
