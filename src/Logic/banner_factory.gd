extends Node

class_name BannerFactory

# Called when the node enters the scene tree for the first time.
static func create_banner(position : Vector2, region_name : String, nation : String):
	var banner : RemovableSprite = RemovableSprite.new()
	banner.position = position
	banner.sprite_name = "Banner" + nation
	banner.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	banner.texture = load("res://assets/Banner/Banner" + nation + ".png")
	return banner
	
