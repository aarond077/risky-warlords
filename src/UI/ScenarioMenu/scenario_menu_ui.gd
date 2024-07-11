extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "nation_selected", on_nation_selected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_nation_selected(nation_name : String, player_index : int):
	print("hello")
	ScenarioDataManager.scenario_players[player_index - 1].set_nation(nation_name)
