extends Camera2D

class_name ZoomingCamera

# Lower cap for the `_zoom_level`.
@export var min_zoom := 3.0
# Upper cap for the `_zoom_level`.
@export var max_zoom : float = 10.0
# Controls how much we increase or decrease the `_zoom_level` on every turn of the scroll wheel.
@export var zoom_factor : float = 0.2
# Duration of the zoom's tween animation.
@export var zoom_duration : float = 0.2

# The camera's target zoom level.
@onready var zoom_level : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		position = event.position - Vector2(300, 300)
#		position -= event.relative / zoom_level
	if event.is_action_pressed("zoom_in"):
		#position -= event.relative / zoom
		zoom += Vector2(zoom_factor, zoom_factor)
	elif event.is_action_pressed("zoom_out"):
		#position -= event.relative / zoom
		zoom -= Vector2(zoom_factor, zoom_factor) 
	zoom = clamp(zoom, Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
