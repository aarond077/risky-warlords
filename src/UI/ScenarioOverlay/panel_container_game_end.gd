extends PanelContainer

@onready var winning_player_label : Label = $VBoxContainer/WinningPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "game_end", on_game_end)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_game_end():
	winning_player_label.text ="Spieler " + str(ScenarioDataManager.active_player.player_index)

func _on_back_to_menu_button_pressed():
	SceneManager.switch_scene("ScenarioMenu")
