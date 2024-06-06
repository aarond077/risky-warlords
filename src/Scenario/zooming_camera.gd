extends Camera2D

class_name ZoomingCamera

const MAX_ZOOM : float = 6.0
const MIN_ZOOM : float = 1.8

#function for handeling zooming in
func zoom_in():
	var current_zoom = self.zoom 
	if(current_zoom.x <= MAX_ZOOM and MAX_ZOOM <= 6):
		self.set_zoom(current_zoom * 1.05) 
		self.set_scale(Vector2((1/zoom.x), (1/zoom.y)))

#function for handeling zooming out
func zoom_out():
	var current_zoom = self.zoom
	if(current_zoom.x >= MIN_ZOOM and current_zoom.y >= MIN_ZOOM):
		self.set_zoom(current_zoom * 0.95)
		self.set_scale(Vector2((1/zoom.x), (1/zoom.y)))

#function for handeling mouse movement to move the camera
func move_offset(event):
	var rel_x = event.relative.x
	var rel_y = event.relative.y
	var cam_pos = self.get_offset()
	var current_zoom = self.zoom

	cam_pos.x -= rel_x / current_zoom.x
	cam_pos.y -= rel_y / current_zoom.y
	if(cam_pos.x >= limit_left and cam_pos.y >= limit_top
		and cam_pos.x <= limit_right and cam_pos.y <= limit_bottom):
		self.set_offset(cam_pos)

#function for handeling user input such as moving the mouse or zooming (pressing left
# or right mouse and then mousewheel)
func _unhandled_input(event):
	if event is InputEventMouseMotion and event.button_mask > 0:
		self.move_offset(event)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		self.zoom_in()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		self.zoom_out()
