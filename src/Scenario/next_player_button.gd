extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if((ScenarioDataManager.battle_phase_active \
		or not ScenarioDataManager.start_round_active) \
		and not ScenarioDataManager.battle_container_shown):
		ScenarioDataManager.set_next_active_player()
		SignalBus.call_deferred(
		"emit_signal",
		"continue_active_player_timer"
	)
		SignalBus.emit_signal("start_active_player_timer")
	
