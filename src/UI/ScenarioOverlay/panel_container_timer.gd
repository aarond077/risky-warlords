extends PanelContainer

@onready var player_timer = $PlayerTimer
@onready var timer_label = $GridContainer/PlayerTimerLabel
@onready var counter : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "start_active_player_timer", on_start_active_player_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += 1
	if counter % 6 == 0:
		update_time_label()
		counter = 0

func update_time_label():
	if player_timer.time_left >= 10:
		timer_label.text = "0:"+str(int(player_timer.time_left)) #cast because of rounding
		return
	timer_label.text = "0:0"+str(int(player_timer.time_left))
	
func on_start_active_player_timer():
	print("halli")
	player_timer.start()
