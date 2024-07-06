extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "set_political_view", background_visible) # Replace with function body.
	SignalBus.call_deferred("connect", "set_physical_view", background_not_visible) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func background_visible():
	visible = true
func background_not_visible():
	visible = false
