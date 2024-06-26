extends PanelContainer

@onready var warriors_label : Label = $GridContainer/MarginWarriors/WarriorsLabel
@onready var archers_label : Label = $GridContainer/MarginBow/BowCount
@onready var tanks_label : Label = $GridContainer/MarginArmor/ArmorCount


func _ready():
	SignalBus.call_deferred("connect", "update_player_army_label", on_update_player_army_label)
	SignalBus.call_deferred("connect", "next_active_player", on_next_active_player)

func on_update_player_army_label(player : Player):
	update_player_army_label(
		player.army["Warriors"],
		player.army["Archers"],
		player.army["Tanks"]
		)

func on_next_active_player():
	var active_player : Player = ScenarioDataManager.active_player
	print(active_player.army["Warriors"])
	update_player_army_label(
		active_player.army["Warriors"],
		active_player.army["Archers"],
		active_player.army["Tanks"]
		)

func update_player_army_label(warriors : int, archers : int, tanks : int):
	update_warriors_label(warriors)
	update_archers_label(archers)
	update_tanks_label(tanks)

func update_warriors_label(warriors : int):
	warriors_label.text = str(warriors)

func update_archers_label(archers : int):
	archers_label.text = str(archers)

func update_tanks_label(tanks : int):
	tanks_label.text = str(tanks)
