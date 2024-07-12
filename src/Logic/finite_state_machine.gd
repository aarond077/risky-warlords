extends Node

class_name FiniteStateMachine



@onready var new_state : State
@onready var init_state : String
@onready var current_state : State
@onready var previous_state : State

@onready var panel_container_timer : PanelContainer = $"../../CanvasLayer/ScenarioOverlay/PanelContainerTimer"
@onready var panel_container_army : PanelContainer = $"../../CanvasLayer/ScenarioOverlay/PanelContainerArmy"
@onready var panel_container_region : PanelContainer = $"../../CanvasLayer/ScenarioOverlay/PanelContainerRegion"
@onready var panel_container_info : PanelContainer = $"../../CanvasLayer/ScenarioOverlay/PanelContainerInfo"
@onready var panel_container_resources : PanelContainer = $"../../CanvasLayer/ScenarioOverlay/PanelContainerResources"
@onready var panel_container_political_view : PanelContainer = $"../../CanvasLayer/ScenarioOverlay/PanelContainerPoliticalView"
@onready var panel_container_actions : PanelContainer = $"../../CanvasLayer/ScenarioOverlay/PanelContainerActions"
@onready var panel_container_battle : PanelContainer = $"../../CanvasLayer/ScenarioOverlay/PanelContainerBattle"
@onready var panel_container_battle_results : PanelContainer = $"../../CanvasLayer/ScenarioOverlay/PanelContainerBattleResults"
@onready var panel_container_select_army : PanelContainer = $"../../CanvasLayer/ScenarioOverlay/PanelContainerSelectArmy"
@onready var panel_container_trade_resources : PanelContainer = $"../../CanvasLayer/ScenarioOverlay/PanelContainerTradeRessources"


@export var debug : Label

var states : Array[State]


#makes sure the initial state is set and also connects child states with the state interrupt signal
func _ready():
	for child in get_children():
		if(child is State): #internal check if child is a state node
			states.append(child)

			# Set the states up with what they need to function

			child.connect("interrupt_state", on_state_interrupt_state)

		else:
			push_warning("Child " + child.name + " is not a State for FiniteStateMachine")
#
	current_state = get_child(0) as State #set the first state of the state machines child nodes as the inital state
	previous_state = current_state #sets the previous state as the initial state
	current_state.call_deferred("enter") #calls enter function of the initial state
	
	#debug.text = current_state.name
	pass

func change_state(state):
	new_state = find_child(state) as State #string search of the new state
	current_state.exit() #exits out of the current state
	new_state.enter() #enters the next state
	
	previous_state = current_state #sets the previous state as the state that is exited
	current_state = new_state #sets the current state as the state that is entered
	SignalBus.emit_signal("update_phase_label", current_state.name)

#returns back to previous state
func transition_previous_state():
	change_state(previous_state)

func return_current_state():
	return current_state

#parses the delta value to the states individual process 
#function to encapsulate the process function via state distinction
func _process(delta):
	current_state.state_process(delta)

#parses the event value (User Input) to the states individual process 
#function to encapsulate the process function via state distinction
func _input(event):
	current_state.state_input(event)

func on_state_interrupt_state(new_state : String):
	change_state(new_state)
	
	
