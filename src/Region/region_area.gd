extends Area2D

var region_name : String = ""
var region_index : int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_child_entered_tree(node):
	if node is Polygon2D: #node.is_class("Polygon2D"):
		#node.color = Color(0, 1, 0, 1) #1, 1, 1, 0.5
		node.color = Color(0, 0, 0, 0)
		#node.color = Color(0.1, 1, 0, 0)
		pass
		


func _on_mouse_entered():
	print(region_name)
	for node in get_children():
		if node.is_class("Polygon2D"):
			node.color = Color(1, 1, 1, 0.5)
			#node.modulate = Color(1, 1, 1, 0.5)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		print(str(region_name) + " Clicked. Index: " + str(self.region_index) )
		SignalBus.call_deferred("emit_signal", "region_clicked", self.region_name)


func _on_mouse_exited():
	#print(region_name)
	for node in get_children():
		if node.is_class("Polygon2D"):
			node.color = Color(0, 0, 0, 0)
