extends Node2D

@onready var player_timer : Timer = $"../CanvasLayer/ScenarioOverlay/PanelContainerTimer/Timer"

func _ready():
	pass
	


func _on_timer_timeout():
	print(ScenarioDataManager.active_player.nation)
	ScenarioDataManager.set_next_active_player()
	player_timer.start()
	
