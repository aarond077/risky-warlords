extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_option_button_item_selected(index):
	if index >=0:
		visible = true # Replace with function body.
	else:
		visible = false
