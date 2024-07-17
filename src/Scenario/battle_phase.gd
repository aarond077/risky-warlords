extends State

@onready var can_transition : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "init_start_round", on_init_start_round)
	SignalBus.call_deferred("connect", "game_end", on_game_end)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if can_transition:
		self.call_deferred("emit_signal", "interrupt_state", "StartRound")
	
func enter():
	super.enter()
	ScenarioDataManager.battle_phase_active = true
	if(not ScenarioDataManager.exist_possible_battle()):
		can_transition = true
	
	#var start_player : Player
	#var player_found : bool = false
	#for player in ScenarioDataManager.scenario_players:
		#if(ScenarioDataManager.player_has_possible_battles(player)):
			#start_player = player
			#player_found = true
	#if not(player_found):
		#can_transition = true
	else:
		#ScenarioDataManager.active_player = start_player
		AudioManager.play_fightStart()
		AudioManager.play_fight()
		AudioManager.transitionAudio(AudioManager.scene, AudioManager.fight)
		set_battle_phase_ui()

func exit():
	super.exit()
	can_transition = false
	ScenarioDataManager.battle_phase_active = false
	
func set_battle_phase_ui():
	get_parent().panel_container_actions.visible = false

func on_init_start_round():
	can_transition = true
	AudioManager.play_scene()
	AudioManager.transitionAudio(AudioManager.fight, AudioManager.scene)	
	
func on_game_end():
	print("game ended?")
	call_deferred("emit_signal", "interrupt_state", "GameEnd")

