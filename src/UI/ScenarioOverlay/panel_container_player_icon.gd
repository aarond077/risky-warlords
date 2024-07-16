extends PanelContainer

@onready var player_icon : TextureRect = $PlayerIcon
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("update_player_icon", on_update_player_icon)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_update_player_icon(player : Player):
	player_icon.texture = load(
		"res://src/UI/ScenarioOverlay/Sonstiges/Portrait" 
		+ player.nation 
		+ ".png")
	
