extends PanelContainer

@onready var player_info_label : Label = $GridContainer/MarginPlayerInfo/PlayerInfoLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "next_active_player", on_next_active_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_next_active_player():
	player_info_label.text = "Spieler " \
		+ str(ScenarioDataManager.active_player.player_index)

	
