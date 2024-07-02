extends PanelContainer

@onready var toggled : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_political_view_button_toggled(toggled_on):
	if toggled_on:
		SignalBus.call_deferred("emit_signal", "set_political_view")
	else:
		SignalBus.call_deferred("emit_signal", "set_physical_view")
			
