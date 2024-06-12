extends State

@onready var can_transition : bool = false
@onready var state_machine : FiniteStateMachine = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func state_process(delta):
	if self.can_transition:
		call_deferred("emit_signal", "interrupt_state", "ActionPoints")

func hide_action_point_state_ui():
	state_machine.panel_container_timer.visible = false
	#get_parent().panel_container_army.visible = false
	state_machine.panel_container_region.visible = false
	#get_parent().panel_container_info.visible = false
	#get_parent().panel_container_resources.visible = false
	#get_parent().panel_container_political_view.visible = false
	state_machine.panel_container_actions.visible = false
	#get_parent().set_deferred("panel_container_timer.visible", false)
	#get_parent().set_deferred("panel_container_army.visible", false)
	#get_parent().set_deferred("panel_container_region.visible", false)
	#get_parent().set_deferred("panel_container_info.visible", false)
	#get_parent().set_deferred("panel_container_resources.visible", false)
	#get_parent().set_deferred("panel_container_political_view.visible", false)
	#get_parent().set_deferred("panel_container_actions.visible", false)

func show_start_round_state_ui():
	state_machine.panel_container_select_army.visible = true
	
	
func enter():
	super.enter()
	self.can_transition = false
	
	
	call_deferred("hide_action_point_state_ui")
	call_deferred("show_start_round_state_ui")
	
	ScenarioDataManager.update_player_resources()
	
	SignalBus.call_deferred(
		"emit_signal",
		 "update_player_resources_label",
		 ScenarioDataManager.active_player)
	
	

func exit():
	super.exit()
	self.can_transition = false
	
func is_active_player_last_player()-> bool:
	return ScenarioDataManager.active_player.player_index == ScenarioDataManager.scenario_players.size()
	

func _on_confirm_button_pressed():
	if (is_active_player_last_player()):
		ScenarioDataManager.set_next_active_player()
		self.can_transition = true
	else:
		ScenarioDataManager.set_next_active_player()
