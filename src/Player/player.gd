extends Node

class_name Player

@onready var regions : RegionGraph
@onready var player_name : String
@onready var player_index : int
@onready var capital : String
@onready var nation : String
@onready var army : Dictionary = {"Sword" : 0, "Bow" : 0, "Heavy" : 0}
@onready var army_points : int 
@onready var action_points : int
@onready var resources : Dictionary = {"Wood" : 0, "Stone" : 0, "Metal" : 0, "Food" : 0}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
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

func set_army(sword_army : int, bow_army : int, heavy_army : int ):
	self.set_sword_army(sword_army)
	self.set_bow_army(bow_army)
	self.set_heavy_army(heavy_army)

func set_sword_army(sword_army : int):
	self.army["Sword"] = sword_army

func set_bow_army(bow_army : int):
	self.army["Bow"] = bow_army
	
func set_heavy_army(heavy_army : int):
	self.army["Heavy"] = heavy_army
	
