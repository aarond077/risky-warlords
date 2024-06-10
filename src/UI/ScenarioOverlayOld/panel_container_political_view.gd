extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_political_view_button_pressed():
	if ScenarioDataManager.political_view:
		SignalBus.call_deferred("emit_signal", "set_physical_view")
	else:
		SignalBus.call_deferred("emit_signal", "set_political_view")
