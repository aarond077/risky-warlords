extends PanelContainer

var resources : Dictionary

var check : Dictionary = {"Stone": false, "Wood" : false, "Iron": false, "Food" : false}
var true_values_dict : Dictionary = {}

var maxClick : int = 0
var choosenResource :  String
var amount : int = 0

@onready var stoneButton : BaseButton = $VBoxContainer/GridContainer/MarginCheckStone/CheckStone
@onready var woodButton : BaseButton = $VBoxContainer/GridContainer/MarginCheckWood/CheckWood
@onready var metalButton : BaseButton = $VBoxContainer/GridContainer/MarginCheckMetal/CheckMetal
@onready var foodButton : BaseButton = $VBoxContainer/GridContainer/MarginCheckFood/CheckFood


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ressourcen_tauschen_pressed():
	visible = true
	resources = ScenarioDataManager.active_player.resources
	SignalBus.call_deferred("emit_signal", "pause_active_player_timer")
	AudioManager.play_select()

func _on_check_stone_toggled(toggled_on):
	if toggled_on:
		if maxClick >= 2 or resources["Stone"] == 0:
			stoneButton.button_pressed = false
			maxClick +=1
		else:
			check["Stone"] = true
			maxClick +=1
	else:
		check["Stone"] = false
		maxClick -=1


func _on_check_wood_toggled(toggled_on):
	if toggled_on:
		if maxClick >= 2 or resources["Wood"] == 0:
			woodButton.button_pressed = false
			maxClick +=1
		else:
			check["Wood"] = true
			maxClick +=1
	else:
		check["Wood"] = false
		maxClick -=1


func _on_check_metal_toggled(toggled_on):
	if toggled_on:
		if maxClick >= 2 or resources["Iron"] == 0:
			metalButton.button_pressed = false
			maxClick +=1
		else:
			check["Iron"] = true
			maxClick +=1
	else:
		check["Iron"] = false
		maxClick -=1


func _on_check_food_toggled(toggled_on):
	if toggled_on:
		if maxClick >= 2 or resources["Food"] == 0:
			foodButton.button_pressed = false
			maxClick +=1
		else:
			check["Food"] = true
			maxClick +=1
	else:
		check["Food"] = false
		maxClick -=1


func _on_choose_ressource_item_selected(index):
	if index == 0:
		choosenResource = "Stone"
	if index == 1:
		choosenResource = "Wood"
	if index == 2:
		choosenResource = "Iron"
	if index == 3:
		choosenResource = "Food"


func _on_ressource_decrease_button_pressed():
	if amount == 0:
		pass
	else:
		amount -=1
	if amount == 0:
		disableButtons(false)
	update_resource_label() # Replace with function body.

func disableButtons(arg : bool):
	stoneButton.disabled = arg
	woodButton.disabled = arg
	metalButton.disabled = arg
	foodButton.disabled = arg
	
func _on_ressource_increase_button_pressed():
	if checkTrade():
		amount +=1
		disableButtons(true)
	else:
		pass
	update_resource_label()

func update_resource_label():
	var resourceLabel : Label = $VBoxContainer/HBoxContainer4/MarginContainer2/RessourceAmount
	resourceLabel.text = str(amount)

func checkTrade():
	var tradeValid : bool = false
	true_values_dict = {}
	
	for key in check.keys():
		if check[key]:
			true_values_dict[key] = check[key]
	
	if len(true_values_dict) == 2:
		var keysTrue = true_values_dict.keys()
		if resources[keysTrue[0]] > amount and resources[keysTrue[1]] > amount:
			tradeValid = true
		
	return tradeValid


func _on_confirm_button_pressed():
	var active_player = ScenarioDataManager.active_player
	if amount != 0 and choosenResource and active_player.action_points > 1:
		var keysTrue = true_values_dict.keys()
		if keysTrue[0] == "Stone" or keysTrue[1] == "Stone":
			active_player.reduce_resource_stone(amount)
		if keysTrue[0] == "Wood" or keysTrue[1] == "Wood":
			active_player.reduce_resource_wood(amount)
		if keysTrue[0] == "Iron" or keysTrue[1] == "Iron":
			active_player.reduce_resource_iron(amount)
		if keysTrue[0] == "Food" or keysTrue[1] == "Food":
			active_player.reduce_resource_food(amount)
			
		if choosenResource == "Stone":
			active_player.add_resource_stone(amount)
		if choosenResource == "Wood":
			active_player.add_resource_wood(amount)
		if choosenResource == "Iron":
			active_player.add_resource_iron(amount)
		if choosenResource == "Food":
			active_player.add_resource_food(amount)
		SignalBus.call_deferred("emit_signal", "update_player_resources_label", active_player)
		SignalBus.call_deferred("emit_signal", "continue_active_player_timer")
		active_player.action_points -= 2
		SignalBus.emit_signal("update_player_action_points_label", active_player)
		AudioManager.play_goldCoin()
		reset_trade_resources()
		visible = false
	else:
		pass
		
func reset_trade_resources():
	stoneButton.button_pressed = false
	woodButton.button_pressed = false
	metalButton.button_pressed = false
	foodButton.button_pressed = false
	amount = 0
	true_values_dict = {}
	resources = {}
	disableButtons(false)
	update_resource_label()
	


func _on_cancel_button_pressed():
	reset_trade_resources()
	visible = false
	SignalBus.call_deferred("emit_signal", "continue_active_player_timer")
