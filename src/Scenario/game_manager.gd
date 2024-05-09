extends Node2D

class_name GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

#input function handling user input
func _input(event : InputEvent):
	if(event.is_action_pressed("ui_cancel")): #if user presses esc game stops
		var current_value : bool = get_tree().paused #get the current state of the game tree process
		get_tree().paused = !current_value #toggle game tree state to pause and unpause
		

