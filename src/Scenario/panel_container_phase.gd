extends PanelContainer

@onready var current_phase_label : Label = $CurrentPhase
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("update_phase_label", on_update_phase_label)


func on_update_phase_label(phase : String):
	if(phase == "StartRound"): phase = "Rundenstart";
	elif(phase == "ActionPoints"): phase = "Aktionspunkte"
	elif(phase == "BattlePhase"): phase = "Kampfphase";
	current_phase_label.text = phase
