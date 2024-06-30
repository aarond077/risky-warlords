extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "set_political_view", hideMap)
	SignalBus.call_deferred("connect", "set_physical_view", showMap)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func hideMap():
	visible = false
func showMap():
	visible = true
