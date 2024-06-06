extends State


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func state_process(delta):
	pass
	
func enter():
	super.enter()
	if(ScenarioDataManager.active_player == null):
		ScenarioDataManager.set_start_scenario_active_player()
	print(ScenarioDataManager.active_player.player_index)
