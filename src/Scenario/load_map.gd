extends State

@onready var can_transition

func enter():
	if(ScenarioDataManager.active_player == null):
		ScenarioDataManager.set_start_scenario_active_player()
	
	#ScenarioDataManager.scenario_region_graph.load_regions_to_array()
	
	ScenarioDataManager.scenario_region_graph.create_region_graph_from_file(
		ScenarioDataManager.scenario_map_name
	)
	
	ScenarioDataManager.scenario_region_graph.load_resources_to_array()
	
	ScenarioDataManager.set_scenario_players_capitals(
		ScenarioDataManager.capitals
	)
	
	SignalBus.call_deferred("emit_signal", "create_army_count_labels")
	
	SignalBus.call_deferred("emit_signal", "draw_capitals_fortress")
	
	can_transition = true

func state_process(delta):
	if can_transition:
		self.call_deferred("emit_signal", "interrupt_state", "StartRound")
	
