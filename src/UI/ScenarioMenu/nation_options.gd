extends OptionButton

@onready var player_index = get_parent().player_index
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_selected(index):
	SignalBus.call_deferred("emit_signal", "nation_selected", self.text, player_index)
