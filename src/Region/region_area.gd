extends Area2D

var region_name : String = ""
var region_index : int
var claim_color = Color(0, 0, 0, 1)
var color = claim_color

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "set_political_view", on_set_political_view)
	SignalBus.call_deferred("connect", "set_physical_view", on_set_physical_view)
	SignalBus.call_deferred("connect", "update_political_view", on_update_political_view)

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

func draw_political_view():
	var regions_with_owner : Dictionary = ScenarioDataManager.region_with_owner()
	draw_region_outlines()
	for child in get_children():
		if child is Polygon2D:
			for region in regions_with_owner:
				var key = regions_with_owner[region]
				if key == 1 && region_name == region:
					child.color = map_index_to_color(0)
				elif key == 2 && region_name == region:
					child.color = map_index_to_color(1)
				elif key == 3 && region_name == region:
					child.color = map_index_to_color(2)
				elif key == 4 && region_name == region:
					child.color = map_index_to_color(3)
				elif key == 0 && region_name == region:
					child.color = Color(0.70,0.70,0.70,0.9)

func find_region_color(node) -> Color:
	var color : Color
	if (ScenarioDataManager.political_view_active == true):# and (node.color == Color(1, 1, 1, 0.5) or node.color == Color(0,1,0,0.5) or node.color == Color(1,0,0,0.5)):
		var target_region = ScenarioDataManager.find_region_in_array(self.region_name)	
		for player in ScenarioDataManager.scenario_players:
			if player.player_index == target_region.region_owner_index:
				color = map_index_to_color(player.player_index - 1)
				return color
		color = Color(0.70,0.70,0.70,0.9)
	elif ScenarioDataManager.political_view_active == false:
		color = Color(0, 0, 0, 0)
	return color
	
func map_index_to_color(index) -> Color:
	var color_code : Color
	var rdm : float = randf_range(0.6,0.8)
	var color : String = ScenarioDataManager.scenario_players[index].player_color
	if color == "Blue":
		color_code = Color(0.2,0,rdm,0.8)
	elif color == "Orange":
		color_code = Color(1,rdm,0,0.7)
	elif color == "Purple":
		color_code = Color(rdm,0.2,0.7,0.7)
	elif color == "Yellow":
		color_code = Color(rdm,0.85,0,0.7)
	else:
		color_code = Color(1,1,1,0.4)
	return color_code
	
func on_update_political_view() -> void:
	if ScenarioDataManager.political_view_active:
		draw_political_view()

func on_set_political_view() -> void:
	ScenarioDataManager.political_view_active = true
	draw_political_view()
	
			
			
func on_set_physical_view():
	var active_region_name = ""
	if ScenarioDataManager.active_region:
		active_region_name = ScenarioDataManager.active_region.region_name
	ScenarioDataManager.political_view_active = false
	SignalBus.call_deferred("emit_signal", "remove_region_outlines", self.region_name)
	for child in get_children():
		if child is Polygon2D:
			_on_child_entered_tree(child)
			if active_region_name == region_name:
				call_deferred("draw_region_outlines")
				

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
		for node in get_children():
			if node.is_class("Polygon2D") and not ScenarioDataManager.battle_container_shown:
				if ScenarioDataManager.active_player.army_movement and not ScenarioDataManager.battle_phase_active:
					if ScenarioDataManager.region_is_accessable_for_movement(region_name) and ScenarioDataManager.political_view_active == false:
						node.color = Color(0,1,0,0.5)
					elif (ScenarioDataManager.region_is_accessable_for_movement(region_name)) and (ScenarioDataManager.political_view_active):# and (node.color == Color(0.70,0.70,0.70,0.9)):
						node.color = Color(0,1,0,0.5)
					#elif (ScenarioDataManager.political_view_active) and (node.color != Color(0.70,0.70,0.70,0.9)):
					#	passf
					else:
						node.color = Color(1,0,0,0.5)
				#elif (ScenarioDataManager.political_view_active) and node.color == Color(0.70,0.70,0.70,0.9) and not ScenarioDataManager.battle_phase_active:
				#		node.color = Color(1, 1, 1, 0.5)
				#elif ScenarioDataManager.political_view_active == false and not ScenarioDataManager.battle_phase_active:
				#	node.color = Color(1, 1, 1, 0.5)
				elif ScenarioDataManager.battle_phase_active and ScenarioDataManager.active_player.army_movement:
					if ScenarioDataManager.active_region != null:
						if ScenarioDataManager.region_is_accessable_for_attack(region_name):
							node.color = Color(0,1,0,0.5)
						else:
							node.color = Color(1,0,0,0.5)
				elif ScenarioDataManager.political_view_active:
					node.color = Color(1, 1, 1, 0.5)
				elif not ScenarioDataManager.political_view_active:
					node.color = Color(1, 1, 1, 0.5)
				else:
					node.color = Color(1, 1, 1, 0.5)
				#node.modulate = Color(1, 1, 1, 0.5)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and event.is_pressed() \
		and not ScenarioDataManager.battle_container_shown:
		if not ScenarioDataManager.active_player.army_movement:
			print(str(region_name) + " Clicked. Index: " + str(self.region_index) )
			SignalBus.call_deferred("emit_signal", "region_clicked", self.region_name)
			if ScenarioDataManager.battle_phase_active:
				ScenarioDataManager.active_player.army_movement = true
			print(str(event.position))
		elif ScenarioDataManager.active_player.army_movement \
			and ScenarioDataManager.region_is_accessable_for_movement(region_name) \
			and not ScenarioDataManager.battle_phase_active:
			SignalBus.call_deferred("emit_signal", "show_move_army_container", self.region_name, ScenarioDataManager.active_player)
			ScenarioDataManager.active_player.army_movement = false
		elif ScenarioDataManager.battle_phase_active \
			and ScenarioDataManager.active_player.army_movement:
			if ScenarioDataManager.region_is_accessable_for_attack(region_name):
				SignalBus.call_deferred("emit_signal", "show_battle_container", self.region_name, ScenarioDataManager.active_player)
				ScenarioDataManager.active_player.army_movement = false
		if( not ScenarioDataManager.political_view_active \
			and not ScenarioDataManager.active_player.army_movement \
			and not ScenarioDataManager.battle_phase_active \
			and not ScenarioDataManager.start_round_active):
			SignalBus.call_deferred("emit_signal", "remove_region_outlines", self.region_name)
			call_deferred("draw_region_outlines")
	elif event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_RIGHT \
		and event.is_pressed():
			ScenarioDataManager.active_player.army_movement = false
	


func _on_mouse_exited():
	#print(region_name)
		for node in get_children():
			if node.is_class("Polygon2D"):
				node.color = find_region_color(node)
