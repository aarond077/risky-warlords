extends Node

class_name Player

@onready var regions : RegionGraph
@onready var player_name : String
@onready var player_index : int
@onready var capital : String
@onready var nation : String
@onready var army_points : int 
@onready var action_points : int = 0


var resources : Dictionary = {"Wood" : 0, "Stone" : 0, "Iron" : 0, "Food" : 0}
var army : Dictionary = {"Warriors" : 0, "Archers" : 0, "Tanks" : 0}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass#self.army = {"Warrior" : 0, "Archer" : 0, "Tank" : 0}
	

func add_region_to_array(region_name : String):
	var new_region : RegionNode = RegionNode.new()
	var graph_region : RegionNode = ScenarioDataManager.find_region_in_array(region_name)
	
	new_region.region_name = region_name
	new_region.resource = graph_region.resource
	new_region.resource_factor = graph_region.resource_factor
	
	self.regions.region_array.append(new_region)
	
func update_action_points():
	var action_points_offset : int = 10
	self.action_points += action_points_offset

func update_army(warriors : int, archers : int, tanks : int):
	self.army["Warriors"] += warriors
	self.army["Archers"] += archers
	self.army["Tanks"] += tanks


func update_resources():
	for region in self.regions.region_array: #check every reagion in the players region graph
		self.resources["Food"] += 5 #add 5 food per region
		var region_resource : String = region.resource # get resource of the region
		if region_resource != "Null": # check if resource is not null
			self.resources[region_resource] += region.resource_factor #add amount to resource of the player

	
func set_player_index(player_index : int):
	self.player_index = player_index

func set_nation(nation_name : String):
	self.nation = nation_name

func set_resources(wood : int, stone : int, iron : int, food : int):
	self.set_wood(wood)
	self.set_stone(stone)
	self.set_iron(iron)
	self.set_food(food)

func set_wood(wood : int):
	self.resources["Wood"] = wood

func set_stone(stone : int):
	self.resources["Stone"] = stone

func set_iron(iron : int):
	self.resources["Iron"] = iron

func set_food(food : int):
	self.resources["Food"] = food

	
