extends Node

class_name Player

@onready var regions : RegionGraph
@onready var player_name : String
@onready var capital : String
@onready var nation : String
@onready var army : Dictionary
@onready var army_points : int 
@onready var action_points : int
@onready var resources : Dictionary = {"Wood" : 0, "Stone" : 0, "Metal" : 0, "Food" : 0}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass