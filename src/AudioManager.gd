extends AudioStreamPlayer

var menu
var scene
var sceneBehind
var fight
var fightStart
var battleHorn

var wood
var stone
var iron

var goldCoin
var select
var movement
var movementBehind
var drawSword
var tank
var arrow
var dice

var gameEnd

var construction

var muted = false

var transition = false
var vonAudio : AudioStreamPlayer
var toAudio : AudioStreamPlayer




# Called when the node enters the scene tree for the first time.
func _ready():
	menu = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(menu)
	menu.stream = load("res://assets/Music/Soundtracks/The_Great_Battle.mp3")
	menu.volume_db = -10
	menu.bus = "Menu"
	
	
	scene = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(scene)
	scene.stream = load("res://assets/Music/Soundtracks/Rise_of_Kingdoms.mp3")
	scene.volume_db = -10
	scene.bus = "Scene"
	
	sceneBehind = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(sceneBehind)
	sceneBehind.stream = load("res://assets/Music/Soundtracks/wind-outside-sound-ambient-141989.mp3")
	sceneBehind.volume_db = -20
	sceneBehind.bus = "Scene"
	
	fight = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(fight)
	fight.bus = "Scene"
	
	wood = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(wood)
	wood.bus = "SFX"
	
	stone = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(stone)
	stone.bus = "SFX"
	
	iron = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(iron)
	iron.bus = "SFX"
	
	goldCoin = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(goldCoin)
	goldCoin.bus = "SFX"
	
	select = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(select)
	select.bus = "SFX"
	
	movement = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(movement)
	movement.bus = "SFX"
	
	movementBehind = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(movementBehind)
	movementBehind.bus = "SFX"
	
	construction = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(construction)
	construction.bus = "SFX"
	
	drawSword = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(drawSword)
	drawSword.bus = "SFX"
	
	tank = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(tank)
	tank.bus = "SFX"
	
	arrow = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(arrow)
	arrow.bus = "SFX"
	
	dice = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(dice)
	dice.bus = "SFX"
	
	fightStart = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(fightStart)
	fightStart.bus = "SFX"
	
	battleHorn  = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(battleHorn)
	battleHorn.bus = "SFX"
	
	gameEnd = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(gameEnd)
	gameEnd.bus = "Menu"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if transition:
		vonAudio.volume_db -= 10*delta
		toAudio.volume_db += 10*delta
		if toAudio.volume_db >= -10:
			vonAudio.stop()
			transition = false
	
func mute():
	if !muted:
		muted = true
	else:
		muted = false
	if menu.is_playing():
		menu.stop()
	if scene.is_playing():
		scene.stop()
	if fight.is_playing():
		fight.stop()
	if movement.is_playing():
		movementBehind.stop()
		movement.stop()


func play_Menu():
	if not muted:
		menu.volume_db = -10
		menu.play()
		
func transitionAudio(vonAudio : AudioStreamPlayer, toAudio : AudioStreamPlayer):
	self.vonAudio = vonAudio
	self.toAudio = toAudio
	transition = true
	
func play_scene():
	if not muted:
		scene.volume_db = -60
		scene.play()
		sceneBehind.play()
		
func play_fight():
	if not muted:
		var randomInt : int = randi_range(1,2)
		fight.volume_db = -60
		if randomInt == 1:
			fight.stream = load("res://assets/Music/Soundtracks/sb_legionnaire.mp3")
		if randomInt == 2:
			fight.stream = load("res://assets/Music/Soundtracks/Battlefield.mp3")
		fight.play()
	
func play_wood():
	if not muted:
		var randomInt : int = randi_range(1,4)
		if randomInt == 1:
			wood.stream = load("res://assets/Music/Wood/industrial_tools_axe_chop_wood_001.mp3")
		if randomInt == 2:
			wood.stream = load("res://assets/Music/Wood/industrial_tools_axe_chop_wood_002.mp3")
		if randomInt == 3:
			wood.stream = load("res://assets/Music/Wood/industrial_tools_axe_chop_wood_004.mp3")
		if randomInt == 4:
			wood.stream = load("res://assets/Music/Wood/industrial_tools_axe_chop_wood_005.mp3")
		wood.volume_db = -10
		wood.play()

func play_iron():
	if not muted:
		var randomInt : int = randi_range(1,2)
		if randomInt == 1:
			iron.stream = load("res://assets/Music/Iron/zapsplat_industrial_pick_axe_single_hit_on_rock_010_103435.mp3")
		if randomInt == 2:
			iron.stream = load("res://assets/Music/Iron/zapsplat_industrial_pick_axe_single_hit_on_rock_005_103430.mp3")
		iron.volume_db = -10
		iron.play()
		
func play_stone():
	if not muted:
		var randomInt : int = randi_range(1,2)
		if randomInt == 1:
			stone.stream = load("res://assets/Music/Stone/pm_sb_source_46_impact_brick_rock_dirt_gravel_single_hit_292.mp3")
		if randomInt == 2:
			stone.stream = load("res://assets/Music/Stone/zapsplat_industrial_hammer_small_3x_hits_on_rock_60399.mp3")
		stone.volume_db = -10
		stone.play()
		
func play_goldCoin():
	if not muted:
		var randomInt : int = randi_range(1,2)
		if randomInt == 1:
			goldCoin.stream = load("res://assets/Music/GoldCoin/jochi-gold-coins_Qs9MGbDT.mp3")
		if randomInt == 2:
			goldCoin.stream = load("res://assets/Music/GoldCoin/jochi-gold-coins-r8kruwuf_zpQHb7qz.mp3")
		goldCoin.volume_db = -10
		goldCoin.play()
		
func play_select():
	if not muted:
		select.stream = load("res://assets/Music/Select/zapsplat_household_air_fryer_oven_door_close_001_71464.mp3")
		select.volume_db = -15
		select.play()
		
func play_construction():
	if not muted:
		construction.stream = load("res://assets/Music/Construction/zapsplat_industrial_woodsaw_sawing_into_rotten_wood_scoring_short_001_93945.mp3")
		construction.volume_db = -10
		construction.play()
		
func play_drawSword():
	if not muted:
		drawSword.stream = load("res://assets/Music/Weapons/SwordShingA1.ogg")
		drawSword.volume_db = -10
		drawSword.play()
		
func play_tank():
	if not muted:
		tank.stream = load("res://assets/Music/Weapons/shield-bash-sound-effect-medieval-armor_npZa3gLb.mp3")
		tank.volume_db = -10
		tank.play()

func play_arrow():
	if not muted:
		arrow.stream = load("res://assets/Music/Weapons/satisfying-arrow-impact-sound-effect-high-quality_dmwjnn4Z.mp3")
		arrow.volume_db = -10
		arrow.play()
		
func play_gameEnd():
	if not muted:
		mute()
		gameEnd.stream = load("res://assets/Music/Soundtracks/medieval-fanfare-6826.mp3")
		gameEnd.volume_db = -10
		gameEnd.play()
		
func play_dice():
	if not muted:
		var randomInt : int = randi_range(1,4)
		if randomInt == 1:
			dice.stream = load("res://assets/Music/Dice/foley_2_dice_throw_on_carpeted_floor.mp3")
		if randomInt == 2:
			dice.stream = load("res://assets/Music/Dice/foley_2_dice_throw_on_game_board.mp3")
		if randomInt == 3:
			dice.stream = load("res://assets/Music/Dice/zapsplat_leisure_board_game_dice_throw_roll_on_playing_board_003_37259.mp3")
		if randomInt == 4:
			dice.stream = load("res://assets/Music/Dice/zapsplat_leisure_board_game_dice_throw_roll_on_playing_board_006_37262.mp3")
		dice.volume_db = -10
		dice.play()

func play_fightStart():
	if not muted:
		fightStart.stream = load ("res://assets/Music/Weapons/SwordSlashImpactA2.ogg")
		fight.volume_db = -10
		fightStart.play()
		battleHorn.stream = load ("res://assets/Music/Weapons/low-horn-185556.mp3")
		battleHorn.volume_db = -15
		battleHorn.play()
		

func play_movement(region : String):
	movement.stream  = load("")
	movementBehind.stream  = load("")
	var soundDict : Dictionary
	var colorName : String
	var cursedPath: String

	if not muted:
		var map_name = ScenarioDataManager.scenario_map_name
		var file = FileAccess.open(("res://assets/Music/Movement/Maps/" + map_name + ".txt"), FileAccess.READ)
		while not file.eof_reached(): # iterate through all lines until the end of file is reached
			var line = file.get_line()
			var both = line.split(' : ')
			var stringRegionName = str(both[0])
			if stringRegionName == region:
				colorName = str(both[1])
				
		var randomInt : int = randi_range(1,3)
		
		if randomInt == 1:
			cursedPath = "res://assets/Music/Strange/atmosphere-dark-1.mp3"
		if randomInt == 2:
			cursedPath = "res://assets/Music/Strange/atmosphere-dark-2.mp3"
		if randomInt == 3:
			cursedPath = "res://assets/Music/Strange/atmosphere-dark-3.mp3"
		
		movement.volume_db = -15
		
		if colorName == "Snow":
			movement.stream = load("res://assets/Music/Movement/snow_1.mp3")
		if colorName == "Solid":
			movement.stream = load("res://assets/Music/Movement/concreteground_1.mp3")
		if colorName == "SnowMountain":
			movement.stream = load("res://assets/Music/Movement/snow_1.mp3")
			movementBehind.stream = load("res://assets/Music/Movement/concreteground_1.mp3")
		if colorName == "Matsch":
			movement.stream = load("res://assets/Music/Movement/mud_1.mp3")
		if colorName == "Grass":
			movement.stream = load("res://assets/Music/Movement/grass_1.mp3")
		if colorName == "StoneCursed":
			movement.stream = load("res://assets/Music/Movement/gravelchainmail_1.mp3")
			movementBehind.stream = load(cursedPath)
		if colorName == "SolidCursed":
			movement.stream = load("res://assets/Music/Movement/dirtchainmail_1.mp3")
			movementBehind.stream = load(cursedPath)
		if colorName == "MountainCursed":
			movement.stream = load("res://assets/Music/Movement/concreteground_1.mp3")
			movementBehind.stream = load(cursedPath)
		if colorName == "SnowCursed":
			movement.stream = load("res://assets/Music/Movement/snow_1.mp3")
			movementBehind.stream = load(cursedPath)
		if colorName == "GrassCursed":
			movement.stream = load("res://assets/Music/Movement/grass_1.mp3")
			movementBehind.stream = load(cursedPath)
		if colorName == "Mountain":
			movement.stream = load("res://assets/Music/Movement/dirtchainmail_1.mp3")
		if colorName == "Forest":
			movement.stream = load("res://assets/Music/Movement/walking-in-forest.mp3")
			movement.volume_db = -10
		if colorName == "Wüste":
			movement.stream = load("res://assets/Music/Movement/sand_1.mp3")
		if colorName == "Stone":
			movement.stream = load("res://assets/Music/Movement/gravelchainmail_1.mp3")
		movement.play()
		movementBehind.volume_db = -20
		movementBehind.play()
		
