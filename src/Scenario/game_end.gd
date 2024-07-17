extends State

@onready var state_machine : FiniteStateMachine = get_parent()
@onready var winningPlayer : Label = $"../../../CanvasLayer/ScenarioOverlay/PanelContainerGameEnd/VBoxContainer/WinningPlayer"
# Called when the node enters the scene tree for the first time.
func enter():
	AudioManager.play_gameEnd()
	hide_battle_phase_ui()
	show_end_game_ui()
	print("GAME OVER")

func hide_battle_phase_ui():
	state_machine.panel_container_region.visible = false
	state_machine.panel_container_resources.visible = false
	state_machine.panel_container_army.visible = false
	state_machine.panel_container_battle.visible = false
	state_machine.panel_container_battle_results.visible = false
	state_machine.panel_container_info.visible = false
	
func show_end_game_ui():
	state_machine.panel_container_game_end.visible = true
