extends PanelContainer

@onready var attacking_dice_one : TextureRect = $VBoxContainer/GridContainer/PlayerOneDiceOne
@onready var attacking_dice_two : TextureRect = $VBoxContainer/GridContainer/PlayerOneDiceTwo
@onready var attacking_dice_three : TextureRect = $VBoxContainer/GridContainer/PlayerOneDiceThree
@onready var attacking_dice_four : TextureRect = $VBoxContainer/GridContainer/PlayerOneDiceFour
@onready var attacking_dice_five : TextureRect = $VBoxContainer/GridContainer/PlayerOneDiceFive 
@onready var attacking_dice_six : TextureRect = $VBoxContainer/GridContainer/PlayerOneDiceSix

@onready var defending_dice_one : TextureRect = $VBoxContainer/GridContainer2/PlayerTwoDiceOne
@onready var defending_dice_two : TextureRect = $VBoxContainer/GridContainer2/PlayerTwoDiceTwo
@onready var defending_dice_three : TextureRect = $VBoxContainer/GridContainer2/PlayerTwoDiceThree
@onready var defending_dice_four : TextureRect = $VBoxContainer/GridContainer2/PlayerTwoDiceFour
@onready var defending_dice_five : TextureRect = $VBoxContainer/GridContainer2/PlayerTwoDiceFive
@onready var defending_dice_six : TextureRect = $VBoxContainer/GridContainer2/PlayerTwoDiceSix

#@onready var att_region_label : Label = $VBoxContainer/HBoxContainer/Attacker
#@onready var def_region_label : Label = $VBoxContainer/HBoxContainer2/Defender
@onready var att_player_label : Label = $VBoxContainer/GridContainer/MarginContainer/PlayerOne
@onready var def_player_label : Label = $VBoxContainer/GridContainer2/MarginContainer/PlayerTwo
@onready var attacking_player_counter_label : Label = $VBoxContainer/ResultPlayerOne
@onready var defending_player_counter_label : Label = $VBoxContainer/ResultPlayerTwo

@onready var attacking_dice_texture_rects : Array[TextureRect] = [attacking_dice_one, attacking_dice_two, attacking_dice_three, attacking_dice_four, attacking_dice_five, attacking_dice_six]
@onready var defending_dice_texture_rects : Array[TextureRect] = [defending_dice_one, defending_dice_two, defending_dice_three, defending_dice_four, defending_dice_five, defending_dice_six]
var attacking_region : RegionNode 
var defending_region : RegionNode
var attacking_dices : int
var defending_dices : int

var attacking_archers_bonus : bool
var defending_archers_bonus : bool
var attacking_tanks_bonus : bool
var defending_tanks_bonus : bool
var battle_round_finished : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "show_battle_container", on_show_battle_container)
	SignalBus.call_deferred("connect", "next_battle_round", on_next_battle_round)
	SignalBus.call_deferred("connect", "region_defeated", on_region_defeated)

func show_attacking_player_dices() -> void:
	if(get_attacking_dices(attacking_region) >= 3):
			attacking_dice_one.visible = true
			attacking_dice_two.visible = true
			attacking_dice_three.visible = true
	elif(get_attacking_dices(attacking_region) >= 2):
			attacking_dice_one.visible = true
			attacking_dice_two.visible = true
			attacking_dice_three.visible = false
	else:
		attacking_dice_one.visible = true
		attacking_dice_two.visible = false
		attacking_dice_three.visible = false

func show_defending_player_dices() -> void:
	if(get_defending_dices(defending_region) >= 2):
			defending_dice_one.visible = true
			defending_dice_two.visible = true
	else:
		defending_dice_one.visible = true
		defending_dice_two.visible = false

func get_attacking_dices(attacking_region : RegionNode):
		if(attacking_region.count_army() >= 4):
			return 3
		elif(attacking_region.count_army() >= 3):
			return 2
		else:
			return 1
			
func get_defending_dices(defending_region : RegionNode):
	var defending_army : Dictionary = defending_region.region_army
	var defending_offset : int = 0
	if(defending_region.building == "Wachturm" \
		or defending_region.building == "Festung"):
			defending_offset += 1

	if(defending_region.count_army() + \
		defending_offset >= 2):
			return 2
	else:
		return 1
	
	
func throw_dices(dices : int):
	var dices_result : Array[int]
	for dice in range(dices):
		dices_result.append(throw_dice())
	return dices_result

func throw_dice() -> int:
	var rng = RandomNumberGenerator.new()
	var dice : int = rng.randi_range(1, 6)
	return dice
	
func show_attacking_player_results(attacking_results : Array[int]):
	var counter : int = 0
	for dice_result in attacking_results:
		var dice_texture_rect : TextureRect = attacking_dice_texture_rects[counter]
		set_dice_texture(dice_texture_rect, dice_result)
		counter += 1

func show_defending_player_results(defending_results : Array[int]):
	var counter : int = 0
	for dice_result in defending_results:
		var dice_texture_rect : TextureRect = defending_dice_texture_rects[counter]
		set_dice_texture(dice_texture_rect, dice_result)
		counter += 1

func set_dice_texture(dice : TextureRect, result: int):
	if result == 1:
		dice.texture = load("res://assets/Dice/diceOne.png")
	elif result == 2:
		dice.texture = load("res://assets/Dice/diceTwo.png")
	elif result == 3:
		dice.texture = load("res://assets/Dice/diceThree.png")
	elif result == 4:
		dice.texture = load("res://assets/Dice/diceFour.png")
	elif result == 5:
		dice.texture = load("res://assets/Dice/diceFive.png")
	elif result == 6:
		dice.texture = load("res://assets/Dice/diceSix.png")
	

func get_troop_bonus(region_a : RegionNode, region_b : RegionNode, troop_name : String):
	if region_a.region_army[troop_name] > region_b.region_army[troop_name]:
		return true
	else:
		return false
		
func find_min_dice(def_dice : int, att_player_results : Array[int]) -> int:
	var max_diff : int = 256
	var min_dice : int = -1
	for att_dice in att_player_results:
		var diff : int = att_dice - def_dice
		if diff > 0:
			if diff <= max_diff:
				max_diff = diff
				min_dice = att_dice
	return min_dice

func get_battle_results(attacking_player_results : Array[int], defending_player_results : Array[int]):
	var attacking_player_wins : int
	var defending_player_wins : int
	var battle_results : Array = []
	for def_dice in defending_player_results:
		var min_dice : int = find_min_dice(def_dice, attacking_player_results)
		if(min_dice != -1):
			if(attacking_player_results.size() != 1):
				attacking_player_results.erase(min_dice)
			attacking_player_wins += 1
		else:
			defending_player_wins += 1
		
		if(attacking_archers_bonus):
			pass
	#for def_dice in attacking_player_results:
		#for att_dice in defending_player_results:
			#if att_dice > def_dice:
				#attacking_player_wins += 1
			#else:
				#defending_player_wins += 1
			#attacking_player_results.erase(att_dice)
			#defending_player_results.erase(def_dice)
	if(attacking_player_wins > defending_player_wins):
		battle_results.append(attacking_region)
		battle_results.append(defending_region)
	elif(attacking_player_wins == defending_player_wins):
		battle_results.append(attacking_region)
		battle_results.append(attacking_region)
	else:
		battle_results.append(defending_region)
		battle_results.append(attacking_region)
	battle_results.append(defending_player_wins)
	battle_results.append(attacking_player_wins)
	return battle_results
	

func apply_army_losses(troop_losses_attacker : int,
						 troop_losses_defender : int) -> void:
							
	if(self.attacking_archers_bonus):
		if(troop_losses_defender > 0):
			troop_losses_defender += 1
	if(self.defending_archers_bonus):
		if(troop_losses_attacker > 0):
			troop_losses_attacker += 1
	if(self.attacking_tanks_bonus):
		if(troop_losses_attacker > 0):
			troop_losses_attacker -= 1
	if(self.defending_tanks_bonus):
		if(troop_losses_defender > 0):
			troop_losses_defender -= 1
	var defending_army_max : int = defending_region.count_army() 
	var attacking_army_max : int = attacking_region.count_army()
	
	if troop_losses_attacker > attacking_army_max - 1:
		troop_losses_attacker = attacking_army_max
	if troop_losses_defender > defending_army_max:
		troop_losses_defender = defending_army_max
	
	apply_attacking_army_losses(attacking_region, troop_losses_attacker)
	apply_defending_army_losses(defending_region,troop_losses_defender)
				 
			
func apply_attacking_army_losses(region : RegionNode, troop_losses : int) -> void:
	#var counter : int = 1
	for loss in range(troop_losses):
		#counter = 1
		
		if(region.army_ready_to_attack()):
				if(region.region_army["Warriors"] > 0):
					region.region_army["Warriors"] -= 1
				elif(region.region_army["Archers"] > 0):
					region.region_army["Archers"] -= 1
				elif(region.region_army["Tanks"] > 0):
					region.region_army["Tanks"] -= 1
			
func apply_defending_army_losses(region : RegionNode, troop_losses : int) -> void:
	#var counter : int = 1
	for loss in range(troop_losses):
		if(not region.army_is_empty()):
				if(region.region_army["Warriors"] > 0):
					region.region_army["Warriors"] -= 1
				elif(region.region_army["Archers"] > 0):
					region.region_army["Archers"] -= 1
				elif(region.region_army["Tanks"] > 0):
					region.region_army["Tanks"] -= 1
			
		#counter = 1
		#while(not region.army_is_empty()):
			#if counter % 3 == 1:
				#if(region.region_army["Warriors"] > 0):
					#region.region_army["Warriors"] -= 1
					#break
				#else:
					#counter += 1
			#if counter % 3 == 2:
				#if(region.region_army["Archers"] > 0):
					#region.region_army["Archers"] -= 1
					#break
				#else:
					#counter += 1
			#if counter % 3 == 0:
				#if(region.region_army["Tanks"] > 0):
					#region.region_army["Tanks"] -= 1
					#break
			#counter += 1

func update_army_counter_labels():
	var attacking_army_sum : int
	var defending_army_sum : int
	
	attacking_army_sum = attacking_region.region_army["Warriors"] + attacking_region.region_army["Archers"] + attacking_region.region_army["Tanks"]
	defending_army_sum = defending_region.region_army["Warriors"] + defending_region.region_army["Archers"] + defending_region.region_army["Tanks"]
	
	attacking_player_counter_label.text = str(attacking_army_sum)
	defending_player_counter_label.text = str(defending_army_sum)

func update_player_labels():
	att_player_label.text = attacking_region.holder
	def_player_label.text = defending_region.holder
	

	
func reset_battle_container():
	attacking_player_counter_label.text = "0"
	defending_player_counter_label.text = "0"
	
	for dice_rect in attacking_dice_texture_rects:
		dice_rect.visible = false
	for dice_rect in defending_dice_texture_rects:
		dice_rect.visible = false

func on_region_defeated(attacking_region : RegionNode, defending_region : RegionNode):
	reset_battle_container()
	SignalBus.call_deferred(
		"emit_signal",
		"continue_active_player_timer"
	)
	battle_round_finished = false
	ScenarioDataManager.battle_container_shown = false
	self.visible = false

func on_next_battle_round():
	update_army_counter_labels()
	update_player_labels()
	show_attacking_player_dices()
	show_defending_player_dices()
	
	battle_round_finished = false
	
func on_show_battle_container(region_name : String, player : Player):
	attacking_region = ScenarioDataManager.active_region
	defending_region = ScenarioDataManager.find_region_in_array(region_name)
	
	SignalBus.call_deferred(
		"emit_signal",
		"pause_active_player_timer"
	)
	
	attacking_dice_texture_rects  = [attacking_dice_one, attacking_dice_two, attacking_dice_three, attacking_dice_four, attacking_dice_five, attacking_dice_six]
	defending_dice_texture_rects  = [defending_dice_one, defending_dice_two, defending_dice_three, defending_dice_four, defending_dice_five, defending_dice_six]
	
	update_army_counter_labels()
	
	show_attacking_player_dices()
	show_defending_player_dices()
	
	update_player_labels()
	
	battle_round_finished = false
	ScenarioDataManager.battle_container_shown = true
	
	self.visible = true
	
func _on_start_attack_button_pressed():
	if not battle_round_finished and attacking_region.army_ready_to_attack():
		self.attacking_dices = get_attacking_dices(attacking_region)
		self.defending_dices = get_defending_dices(defending_region)
		var attacking_player_results : Array[int] = throw_dices(attacking_dices)
		var defending_player_results : Array[int] = throw_dices(defending_dices)
	
		show_attacking_player_results(attacking_player_results)
		show_defending_player_results(defending_player_results)
	
		self.attacking_archers_bonus = get_troop_bonus(attacking_region, defending_region, "Archers")
		self.defending_archers_bonus = get_troop_bonus(defending_region, attacking_region, "Archers")
	
		self.attacking_tanks_bonus = get_troop_bonus(attacking_region, defending_region, "Tanks")
		self.defending_tanks_bonus = get_troop_bonus(defending_region, attacking_region, "Tanks")
	
		var battle_results : Array = get_battle_results(attacking_player_results, defending_player_results)
	
		var winning_region : RegionNode =battle_results[0]
		var losing_region : RegionNode = battle_results[1]
		var troop_losses_attacker : int = battle_results[2]
		var troop_losses_defender : int = battle_results[3]
	
		apply_army_losses(troop_losses_attacker, troop_losses_defender)
		update_army_counter_labels()
	
			
		battle_round_finished = true
		
		SignalBus.call_deferred("emit_signal", "battle_round_finished", attacking_region, defending_region, winning_region, losing_region, troop_losses_attacker, troop_losses_defender)
	 


func _on_exit_button_pressed():
	reset_battle_container()
	battle_round_finished = false
	ScenarioDataManager.battle_container_shown = false
	SignalBus.call_deferred(
		"emit_signal",
		"continue_active_player_timer"
	)
	self.visible = false
