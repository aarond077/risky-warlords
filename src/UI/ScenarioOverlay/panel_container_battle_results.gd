extends PanelContainer


@onready var winner_label : Label = $VBoxContainer/HBoxContainer/Winner
@onready var att_losses_label : Label = $VBoxContainer/HBoxContainer2/Loser
@onready var def_losses_label : Label = $VBoxContainer/HBoxContainer3/Loser
@onready var att_losses_count_label : Label = $VBoxContainer/HBoxContainer2/TroopsLostInput
@onready var def_losses_count_label : Label = $VBoxContainer/HBoxContainer3/TroopsLostInput


@onready var region_defeated : bool = false
@onready var defending_region : RegionNode
@onready var attacking_region : RegionNode
@onready var winning_region : RegionNode
@onready var losing_region : RegionNode
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "battle_round_finished", on_battle_round_finished)

func update_battle_result_labels(att_loss : int, def_loss : int):
	var att_player_name : String ="Spieler " + str(ScenarioDataManager.find_player_by_holder(attacking_region.holder).player_index)
	var def_player_name : String ="Spieler " + str(ScenarioDataManager.find_player_by_holder(defending_region.holder).player_index)
	var win_player_name : String ="Spieler " + str(ScenarioDataManager.find_player_by_holder(winning_region.holder).player_index)
	if(winning_region.holder == losing_region.holder):
		winner_label.text = "Unentschieden!"
	else:
		winner_label.text = win_player_name + " hat gewonnen!"
	att_losses_label.text = att_player_name
	def_losses_label.text = def_player_name
	att_losses_count_label.text = str(att_loss)
	def_losses_count_label.text = str(def_loss)
	

func on_battle_round_finished(attacking_region : RegionNode,
								 defending_region : RegionNode,
								 winning_region : RegionNode,
								 losing_region : RegionNode,
								 attacker_loss : int,
								 defender_loss : int):
	self.attacking_region = attacking_region
	self.defending_region = defending_region
	self.winning_region = winning_region
	self.losing_region = losing_region
	region_defeated = false

	if(self.defending_region.army_is_empty()):
		region_defeated = true
		print("region defeated")
		
	update_battle_result_labels(attacker_loss, defender_loss)
		
	self.visible = true
	


func _on_exit_button_pressed():
	if(region_defeated):
		SignalBus.emit_signal("region_defeated", attacking_region, defending_region)
	else:
		SignalBus.emit_signal("next_battle_round")
		
	self.visible = false
