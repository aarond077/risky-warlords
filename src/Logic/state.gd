extends Node

class_name State

#@onready var debug = owner.find_child("Debug")
#@onready var player = owner.get_parent().find_child("Player")
#@onready var animation_player = owner.find_child("AnimationPlayer")

signal interrupt_state(new_state : State)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func enter():
	pass

func exit():
	pass
	
func transition():
	pass

func state_process(delta):
	pass


func state_input(event : InputEvent):
	pass

		
func get_state_name():
	pass
