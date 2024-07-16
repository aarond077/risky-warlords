extends State

@onready var can_transition : bool = false
@onready var state_machine : FiniteStateMachine = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "check_player_index", on_check_player_index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func state_process(delta):
	if self.can_transition:
		call_deferred("emit_signal", "interrupt_state", "ActionPoints")

func hide_battle_phase_state_ui():
	#get_parent().panel_container_army.visible = false
	state_machine.panel_container_region.visible = false
	#get_parent().panel_container_info.visible = false
	#get_parent().panel_container_resources.visible = false
	#get_parent().panel_container_political_view.visible = false
	state_machine.panel_container_actions.visible = false
	state_machine.panel_container_battle.visible = false
	state_machine.panel_container_battle_results.visible = false
	#get_parent().set_deferred("panel_container_timer.visible", false)
	#get_parent().set_deferred("panel_container_army.visible", false)
	#get_parent().set_deferred("panel_container_region.visible", false)
	#get_parent().set_deferred("panel_container_info.visible", false)
	#get_parent().set_deferred("panel_container_resources.visible", false)
	#get_parent().set_deferred("panel_container_political_view.visible", false)
	#get_parent().set_deferred("panel_container_actions.visible", false)

func show_start_round_state_ui():
	state_machine.panel_container_select_army.visible = true
	state_machine.panel_container_select_army.reset_select_army_input()
	
func enter():
	super.enter()
	self.can_transition = false
	ScenarioDataManager.start_round_active = true
	
	
	call_deferred("hide_battle_phase_state_ui")
	call_deferred("show_start_round_state_ui")
	
	ScenarioDataManager.update_player_resources()
	ScenarioDataManager.update_player_action_points()
	
	SignalBus.call_deferred(
		"emit_signal",
		"stop_active_player_timer"
	)
	
	SignalBus.call_deferred(
		"emit_signal",
		 "update_player_resources_label",
		 ScenarioDataManager.active_player)
	
	SignalBus.call_deferred(
		"emit_signal",
		 "update_player_army_label",
		 ScenarioDataManager.active_player)
		
	SignalBus.call_deferred(
		"emit_signal",
		"update_player_action_points_label",
		ScenarioDataManager.active_player
	)
	
	ScenarioDataManager.reset_player_army_movement()
	ScenarioDataManager.reset_battle_phase()
	
	

func exit():
	super.exit()
	ScenarioDataManager.start_round_active = false
	self.can_transition = false
	
func is_active_player_last_player()-> bool:
	return ScenarioDataManager.is_active_player_last_player()
	
		
func on_check_player_index():
	if (is_active_player_last_player()):
		self.can_transition = true


