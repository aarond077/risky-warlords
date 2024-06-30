extends Control

class_name ScenarioOverlay
@onready var target_camera : Camera2D = $"../../Scenario/Camera"
@onready var tilemap : TileMap = $"../../Scenario/TileMap"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass#self.position = target_camera.position


func _on_timer_timeout():
	print("Success") # Replace with function body.
	
func _set_political_view():
	SignalBus.call_deferred("emit_signal", "set_political_view")
	
	
