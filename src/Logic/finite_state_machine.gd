extends Node

class_name FiniteStateMachine



@onready var new_state : State
@onready var init_state : String
@onready var current_state : State
@onready var previous_state : State

@export var debug : Label

var states : Array[State]



func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)

			# Set the states up with what they need to function

			child.connect("interrupt_state", on_state_interrupt_state)

		else:
			push_warning("Child " + child.name + " is not a State for FiniteStateMachine")
#
	current_state = get_child(0) as State
	previous_state = current_state
	current_state.call_deferred("enter")
	
	#debug.text = current_state.name
	pass

func change_state(state):
	new_state = find_child(state) as State #string search
	current_state.exit()
	new_state.enter()
	
	previous_state = current_state
	current_state = new_state
	print(state)

	
func transition_previous_state():
	change_state(previous_state)

func return_current_state():
	return current_state

func _process(delta):
	current_state.state_process(delta)

func _input(event):
	current_state.state_input(event)

func on_state_interrupt_state(new_state : String):
	change_state(new_state)
	
	
