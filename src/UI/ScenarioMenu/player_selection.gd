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


