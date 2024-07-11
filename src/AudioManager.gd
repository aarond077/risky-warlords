extends AudioStreamPlayer

var menu
var scene
var fight

var wood
var stone
var iron

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
		
