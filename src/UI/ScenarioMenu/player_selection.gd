extends HBoxContainer

@export var counter : int
@export var player_index : int
@onready var player_label = $PlayerLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	if counter > 0:
		visible = false # Replace with function body.
	else:
		ScenarioDataManager.add_player(player_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_option_button_item_selected(index):
	if index>=counter:
		#player_label.text = "Spieler " + str(index)
		if( not ScenarioDataManager.exist_player(player_index)):
			ScenarioDataManager.add_player(player_index)
		visible = true # Replace with function body.
	else:
		visible = false
		ScenarioDataManager.remove_player(player_index)

func check_color(color_index : int, player_index2 : int):
	var players : Array = ScenarioDataManager.scenario_players
	if color_index == 0:
		players[player_index2].set_player_color("Blue")
	elif color_index == 1:
		players[player_index2].set_player_color("Orange")
	elif color_index == 2:
		players[player_index2].set_player_color("Purple")
	elif color_index == 3:
		players[player_index2].set_player_color("Yellow")
	else :
		players[player_index2].set_player_color("Filler")

func _on_option_button_color_1_item_selected(index):
	check_color(index,0)# Replace with function body.


func _on_option_button_color_2_item_selected(index):
	check_color(index,1) # Replace with function body.


func _on_option_button_color_3_item_selected(index):
	check_color(index,2) # Replace with function body.


func _on_option_button_color_4_item_selected(index):
	check_color(index,3) # Replace with function body.
