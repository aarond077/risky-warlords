extends State

@onready var can_transition : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "init_start_round", on_init_start_round)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if can_transition:
		self.call_deferred("emit_signal", "interrupt_state", "StartRound")
	
func enter():
	super.enter()
	ScenarioDataManager.battle_phase_active = true
	if(not ScenarioDataManager.exist_possible_battle()):
		can_transition = true
	else:
		set_battle_phase_ui()

func exit():
	super.exit()
	can_transition = false
	ScenarioDataManager.battle_phase_active = false
	
func set_battle_phase_ui():
	get_parent().panel_container_actions.visible = false

func on_init_start_round():
	can_transition = true
