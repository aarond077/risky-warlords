extends Line2D

class_name RegionOutline

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "remove_region_outlines", on_remove_region_outlines)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#removes outline (self)
func on_remove_region_outlines(region_name : String):
	self.queue_free()
