extends PanelContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pause_button_toggled(toggled_on):
	if toggled_on:
		AudioManager.play_select()
		print("yes")
		visible = true
		SignalBus.call_deferred("emit_signal", "pause_active_player_timer")
		
	else:
		visible = false # Replace with function body.
		SignalBus.call_deferred("emit_signal", "continue_active_player_timer") # Replace with function body.

func _on_continue_button_pressed():
	visible = false # Replace with function body.
	SignalBus.call_deferred("emit_signal", "continue_active_player_timer")
	var pauseButton : Button = $"../PauseButton"
	pauseButton.button_pressed = false # Replace with function body.


func _on_end_button_2_pressed():
	get_tree().quit() # Replace with function body.


