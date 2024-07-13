extends AudioStreamPlayer

var menu
var scene
var fight

var wood
var stone
var iron

var goldCoin
var select
var movement
var drawSword
var arrow

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
	
	fight = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(fight)
	fight.stream = load("res://assets/Music/Soundtracks/Battlefield.mp3")
	fight.volume_db = -10
	
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
	
	construction = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(construction)
	construction.bus = "SFX"
	
	drawSword = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(drawSword)
	drawSword.bus = "SFX"
	
	arrow = AudioStreamPlayer.new() # Replace with function body.
	self.add_child(arrow)
	arrow.bus = "SFX"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if transition:
		vonAudio.volume_db -= 10*delta
		toAudio.volume_db += 10*delta
		if vonAudio.volume_db <= -60 or toAudio.volume_db >= -10:
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
		transitionAudio(menu, scene)
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
		
func play_movement():
	if not muted:
		movement.stream = load("res://assets/Music/Movement/soldiers-marching-sound-effect_kqIqQTIW.mp3")
		movement.volume_db = -20
		#movement.play()
		
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
			
func play_arrow():
	if not muted:
		arrow.stream = load("res://assets/Music/Weapons/satisfying-arrow-impact-sound-effect-high-quality_dmwjnn4Z.mp3")
		arrow.volume_db = -10
		arrow.play()
		

		
