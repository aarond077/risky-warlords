extends State


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func enter():
	super.enter()
	hide_start_round_state_ui()
	show_action_point_state_ui()
	
	SignalBus.call_deferred("emit_signal", "start_active_player_timer")
	
func hide_start_round_state_ui():
	get_parent().panel_container_select_army.visible = false

func show_action_point_state_ui():
	get_parent().panel_container_timer.visible = true
	get_parent().panel_container_army.visible = true
	get_parent().panel_container_region.visible = true
	get_parent().panel_container_info.visible = true
	get_parent().panel_container_resources.visible = true
	#get_parent().panel_container_political_view.visible = true
	get_parent().panel_container_actions.visible = true
