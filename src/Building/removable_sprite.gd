extends Sprite2D

class_name RemovableSprite

@onready var sprite_name : String
@onready var region_name : String

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "remove_sprite", on_remove_sprite)


func on_remove_sprite(sprite_name : String, region_name : String):
	if(sprite_name == self.sprite_name and region_name == self.region_name):
		self.queue_free()
