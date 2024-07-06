extends Area2D

var region_name : String = ""
var region_index : int
var claim_color = Color(0, 0, 0, 1)
var color = claim_color
var policalviewactive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "set_political_view", draw_in_colour)
	SignalBus.call_deferred("connect", "set_physical_view", physical_view)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#draws one or multiple outlines of one region area
func draw_region_outlines() -> void:
	for child in get_children():
		if child is Polygon2D: #node.is_class("Polygon2D"):
			var outline = RegionOutline.new()
			child.add_child(outline)
			set_outline_points(outline, child)

func draw_in_colour() -> void:
	policalviewactive = true
	for child in get_children():
		if child is Polygon2D:
			child.color = Color(1,0,0,0.8)
			
func physical_view():
	policalviewactive = false
	for child in get_children():
		if child is Polygon2D:
			_on_child_entered_tree(child)
	

#sets the outline coordinates according to the polygons 
func set_outline_points(outline : RegionOutline, polygon : Polygon2D) -> void:
		outline.points = polygon.polygon
		outline.name = "Outline of {name}".format({"name": name})
		outline.default_color = claim_color
		outline.self_modulate.a = 1
		outline.width = 2
		outline.closed = true

func _on_child_entered_tree(node):
	if node is Polygon2D: #node.is_class("Polygon2D"):
		#node.color = Color(0, 1, 0, 1) #1, 1, 1, 0.5
		node.color = Color(0, 0, 0, 0)
		#node.color = Color(0.1, 1, 0, 0)
		pass
		


func _on_mouse_entered():
	#print(region_name)
	if policalviewactive == false:
		for node in get_children():
			if node.is_class("Polygon2D"):
				if ScenarioDataManager.active_player.army_movement == true:
					if ScenarioDataManager.region_is_accessable_for_movement(region_name):
						node.color = Color(0,1,0,0.5)
					else:
						node.color = Color(1,0,0,0.5)
				else:
					node.color = Color(1, 1, 1, 0.5)
				#node.modulate = Color(1, 1, 1, 0.5)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and event.is_pressed():
		if not ScenarioDataManager.active_player.army_movement:
			print(str(region_name) + " Clicked. Index: " + str(self.region_index) )
			SignalBus.call_deferred("emit_signal", "region_clicked", self.region_name)
			SignalBus.call_deferred("emit_signal", "remove_region_outlines", self.region_name)
			call_deferred("draw_region_outlines")
			print(str(event.position))
		elif ScenarioDataManager.active_player.army_movement and ScenarioDataManager.region_is_accessable_for_movement(region_name):
			SignalBus.call_deferred("emit_signal", "show_move_army_container", self.region_name, ScenarioDataManager.active_player)
			ScenarioDataManager.active_player.army_movement = false
	


func _on_mouse_exited():
	#print(region_name)
	if policalviewactive == false:
		for node in get_children():
			if node.is_class("Polygon2D"):
				node.color = Color(0, 0, 0, 0)
