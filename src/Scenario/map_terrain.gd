extends Sprite2D

@onready var map_name : String #= "BuchtVonDessus"
@onready var map_regions_data_name : String #= "bucht_von_dessus.txt"
@onready var pixel_color_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	await load_data()
	call_deferred("load_terrain")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func load_data():
	map_name = ScenarioDataManager.scenario_map_name 
	self.map_regions_data_name = ScenarioDataManager.scenario_map_name 
	self.texture = ResourceLoader.load("res://art/Maps/" + map_name + "/" + map_name + "Terrain.png" )

func load_terrain():
	var pixel_color : String
	var image = self.get_texture().get_image()
	pixel_color_dict = get_pixel_color_dict(image)
	
	#print(pixel_color_dict["#99e550"])	
	#print(pixel_color_dict["#639bff"])
	get_parent().get_node("TileMap").set_cells_terrain_connect(0, pixel_color_dict["#99e550"], 0, 0) #grass
	get_parent().get_node("TileMap").set_cells_terrain_connect(0, pixel_color_dict["#639bff"], 0, 2) #sea
	#get_parent().get_node("TileMap").queue_free()
	queue_free()
	
func get_pixel_color_dict(image):
	var pixel_color_dict = {}
	for y in range(image.get_height()):
		for x in range(image.get_width()):
			var pixel_color = "#" + str(image.get_pixel(int(x), int(y)).to_html(false))
			if pixel_color not in pixel_color_dict:
				pixel_color_dict[pixel_color] = []
			pixel_color_dict[pixel_color].append(Vector2(x, y))
	
	return pixel_color_dict
