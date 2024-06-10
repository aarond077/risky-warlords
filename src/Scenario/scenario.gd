extends Node2D

@onready var player_timer : Timer = $"../CanvasLayer/ScenarioOverlay/PanelContainerTimer/PlayerTimer"
@onready var buildings : Node = $Buildings
func _ready():
	draw_capitals_fortress()
		


func draw_capitals_fortress():
	for player in ScenarioDataManager.scenario_players:
		var position = Vector2(
				ScenarioDataManager.building_coordinates[player.capital][0],
				ScenarioDataManager.building_coordinates[player.capital][1]
			)
		if player.nation == "Menschen":
			var fortress : RemovableSprite = BuildingFactory.create_fortress_humans(
				position, 
				player.capital
			)
			buildings.add_child(fortress)
		elif player.nation == "Zwerge":
			var fortress : RemovableSprite = BuildingFactory.create_fortress_dwarves(
				position, 
				player.capital
			)
			buildings.add_child(fortress)
		elif player.nation == "Elfen":
			var fortress : RemovableSprite = BuildingFactory.create_fortress_elves(
				position, 
				player.capital
			)
			buildings.add_child(fortress)
		elif player.nation == "Orks":
			var fortress : RemovableSprite = BuildingFactory.create_fortress_orcs(
				position, 
				player.capital
			)
			buildings.add_child(fortress)
		if player.nation == "":
			print("ERROR: Player" + str(player.player_index) + "has no nation set")
	


func _on_player_timer_timeout():
	#draw_capitals_fortress()
	#for region in ScenarioDataManager.building_coordinates:
	#	print(region)
	#	print(typeof(region))
	#	for player in ScenarioDataManager.scenario_players:
	#		if(player.capital == region):
	#			print("make sensi")
	
	print(ScenarioDataManager.active_player.capital)
	ScenarioDataManager.set_next_active_player()
	player_timer.start()
	
