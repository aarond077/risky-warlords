extends PanelContainer

@onready var sanctuary_buff_label : Label = $GridContainer/MarginSanctuary/SanctuaryBuff
@onready var troop_buff_label : Label =  $GridContainer/MarginClass/ClassBuff

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "update_buff_label", on_update_buffs_label)

func update_buffs_label(player : Player):
	if(player.sanctuary_bonus == 3):
		sanctuary_buff_label.text = "Heiligum + 1"
	elif(player.sanctuary_bonus == 2):
		sanctuary_buff_label.text = "Heiligum + 0"
	else:
		sanctuary_buff_label.text = "Kein Heiligtum"
	if(player.archers_upgrade and not player.tanks_upgrade):
		troop_buff_label.text = "B + 1"
	elif(player.tanks_upgrade and not player.archers_upgrade):
		troop_buff_label.text = "T + 1"
	elif(player.archers_upgrade and player.tanks_upgrade):
		troop_buff_label.text = "B + 1 | T + 1"
	else:
		troop_buff_label.text = "Kein Truppenupgrade"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func on_next_active_player():
	#update_buffs_label(ScenarioDataManager.active_player)
	
func on_update_buffs_label(player : Player):
	update_buffs_label(player)

