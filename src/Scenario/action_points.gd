extends State

@onready var can_transition : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "init_battle_phase", on_init_battle_phase)


# Called every frame when state is active. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if can_transition:
		self.call_deferred("emit_signal", "interrupt_state", "BattlePhase")
	
func enter():
	super.enter()
	can_transition = false
	hide_start_round_state_ui()
	show_action_point_state_ui()
	
	SignalBus.call_deferred("emit_signal", "start_active_player_timer")

func exit():
	super.exit()
	can_transition = false
	
func hide_start_round_state_ui():
	get_parent().panel_container_select_army.visible = false

func show_action_point_state_ui():
	get_parent().panel_container_army.visible = true
	get_parent().panel_container_region.visible = true
	get_parent().panel_container_info.visible = true
	get_parent().panel_container_resources.visible = true
	#get_parent().panel_container_political_view.visible = true
	get_parent().panel_container_actions.visible = true

func on_init_battle_phase():
	can_transition = true
