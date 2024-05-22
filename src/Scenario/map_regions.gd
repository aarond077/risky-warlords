extends Sprite2D


@onready var map_name : String #= "BuchtVonDessus"
@onready var map_regions_data_name : String #= "bucht_von_dessus.txt"

func _ready():
	await load_data()
	call_deferred("load_regions")

func load_data():
	self.map_name = ScenarioDataManager.scenario_map_name
	self.map_regions_data_name = ScenarioDataManager.scenario_map_name
	self.texture = ResourceLoader.load(
		"res://assets/Maps/" + map_name + "/" + map_name + "Regions.png" )
	#map_image.texture = ResourceLoader.load("res://art/Maps/Bucht/Bucht.png")
	#map_image.texture = ResourceLoader.load("res://art/Maps/Schattensee/Schattensee.png")
	#map_image.texture = ResourceLoader.load("res://art/Maps/Test/Test.png")
	

#Loads the regions of the map using the distinct colors of the map.
#Also assigns polygons according to the regions shape 
func load_regions():
	var image = self.get_texture().get_image()
	var pixel_color_dict = get_pixel_color_dict(image)
	var regions_dict = import_file(
		"res://data/Maps/" + map_name + "/" + map_name + ".txt")
	var regions_dict_indexes = import_file(
		"res://data/Maps/" + map_name + "/" + map_name + "Indexes.txt")
	
	
	#var regions_dict = import_file("res://data/Maps/Bucht/Bucht.txt")
	#var regions_dict = import_file("res://data/Maps/Schattensee/Schattensee.txt")
	#var regions_dict = import_file("res://data/Maps/Test/Test.txt")
	
	for region_color in regions_dict:
		var region = load("res://src/Region/region_area.tscn").instantiate()
		region.region_name = regions_dict[region_color]
		region.set_name(region_color)
		region.region_index = regions_dict_indexes[region.region_name]
		get_parent().get_node("Regions").add_child(region)
		
		var polygons = get_polygons(image, region_color, pixel_color_dict)

		for polygon in polygons:
			var region_collision =  CollisionPolygon2D.new()
			var region_polygon = Polygon2D.new()

			region_collision.polygon = polygon
			region_polygon.polygon = polygon

			region.add_child(region_collision)
			region.add_child(region_polygon)
	
	queue_free()

#Generates polygons using a loop iterating through all the pixels to determine the colors for mapping into polygon
func get_polygons(image, region_color, pixel_color_dict):
	var target_image = Image.create(image.get_size().x, image.get_size().y, false, Image.FORMAT_RGBA8)
	for value in pixel_color_dict[region_color]:
		target_image.set_pixel(value.x, value.y, "#ffffffff")
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(target_image)
	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0, 0), bitmap.get_size()), 0.1)
	return polygons
	
	
#Generates dictionary using the given image. The keys are color codings and the value is an array of pixel coordinates
func get_pixel_color_dict(image):
	var pixel_color_dict = {}
	for y in range(image.get_height()):
		for x in range(image.get_width()):
			var pixel_color = "#" + str(image.get_pixel(int(x), int(y)).to_html(false))
			if pixel_color not in pixel_color_dict:
				pixel_color_dict[pixel_color] = []
			pixel_color_dict[pixel_color].append(Vector2(x, y))
	
	return pixel_color_dict
	
	
	

#access file function
func import_file(filepath : String):
	var file = FileAccess.open(filepath, FileAccess.READ)
	if file != null:
		return JSON.parse_string(file.get_as_text().replace("_", " "))
	else:
		print("Failed to open file:" + filepath)
		return null	
