extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#executes on click of the button
func _on_pressed():
	print("ddddd")
	SceneManager.switch_scene("Scenario")
