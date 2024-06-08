extends PanelContainer

@onready var timer = $PlayerTimer
@onready var timer_label = $GridContainer/PlayerTimerLabel
@onready var counter : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += 1
	if counter % 6 == 0:
		update_time_label()
		counter = 0

func update_time_label():
	if timer.time_left >= 10:
		timer_label.text = "0:"+str(int(timer.time_left))
		return
	timer_label.text = "0:0"+str(int(timer.time_left))
