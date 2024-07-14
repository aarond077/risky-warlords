extends Sprite2D

@onready var map_name : String #= "BuchtVonDessus"
@onready var map_regions_data_name : String #= "bucht_von_dessus.txt"
@onready var pixel_color_dict = {}
@onready var tile_map = get_parent().get_node("TileMap")

var changeset : Dictionary

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
	self.texture = ResourceLoader.load(
		"res://assets/Maps/" + map_name + "/" + map_name + "Terrain.png" )

func load_terrain():
	var pixel_color : String
	var image = self.get_texture().get_image()
	pixel_color_dict = get_pixel_color_dict(image)
	
	if map_name == "Bucht von Dessus":
		draw_bucht_von_dessus_terrain()

	elif map_name == "Aleksud":
		draw_aleksud_terrain()
		
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
	
func draw_bucht_von_dessus_terrain():
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#99e550"], 3) #bright forrest
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#d9a066"], 6) #bright wasteland
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#995d52"], 4) #bright mountains
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#1f4a1f"], 14) #dark forrest
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#b58e34"], 15) #dark wasteland
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#6434be"], 9) #cursed mountains
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#7d598b"], 7) #cursed forrest
			
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#639bff"], 21) #sea
		
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#99e550"]) #bright forrest
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#d9a066"]) #bright wasteland
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#995d52"]) #bright mountains
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#1f4a1f"]) #dark forrest
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#b58e34"]) #dark wasteland
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#6434be"]) #cursed mountains
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#7d598b"]) #cursed forrest	

func draw_sandoria_terrain():
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#99e550"], 3) #bright forrest
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#995d52"], 4) #bright mountains
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#e5b850"], 2) #bright desert
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#b88205"], 13) #dark desert
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#462553"], 17) #snowy mountains
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#1f4a1f"], 14) #dark forrest
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#d9a066"], 6) #bright wasteland
	
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#639bff"], 21) #sea
	
	BetterTerrain.update_terrain_cells(tile_map, 0, pixel_color_dict["#99e550"], 3) #bright forrest
	BetterTerrain.update_terrain_cells(tile_map, 0, pixel_color_dict["#995d52"], 4) #bright mountains
	BetterTerrain.update_terrain_cells(tile_map, 0, pixel_color_dict["#e5b850"], 2) #bright desert
	BetterTerrain.update_terrain_cells(tile_map, 0, pixel_color_dict["#b88205"], 13) #dark desert
	BetterTerrain.update_terrain_cells(tile_map, 0, pixel_color_dict["#462553"], 17) #snowy mountains
	BetterTerrain.update_terrain_cells(tile_map, 0, pixel_color_dict["#1f4a1f"], 14) #dark forrest
	BetterTerrain.update_terrain_cells(tile_map, 0, pixel_color_dict["#d9a066"], 6) #bright wasteland
	
	
func draw_aleksud_terrain():
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#99e550"], 3) #bright forrest
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#d9a066"], 6) #bright wasteland
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#995d52"], 4) #bright mountains
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#1f4a1f"], 14) #dark forrest
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#b58e34"], 15) #dark wasteland
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#6434be"], 9) #cursed mountains
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#7d598b"], 7) #cursed forrest
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#d1da16"], 5) #bright tundra
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#462553"], 17) #snowy mountains
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#5d0b12"], 19) #magma wasteland
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#d95763"], 16) #magma mountain
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#c31fbc"], 11) #cursed wasteland
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#6f6c2d"], 12) #dark canyon
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#6b1a59"], 20) #dark mountains
		
	BetterTerrain.set_cells(tile_map, 0, pixel_color_dict["#639bff"], 21) #sea
		
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#99e550"]) #bright forrest
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#d9a066"]) #bright wasteland
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#995d52"]) #bright mountains
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#1f4a1f"]) #dark forrest
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#b58e34"]) #dark wasteland
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#6434be"]) #cursed mountains
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#7d598b"]) #cursed forrest
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#d1da16"]) #bright tundra
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#462553"]) #snowy mountains
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#5d0b12"]) #magma wasteland
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#d95763"]) #magma mountains
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#c31fbc"]) #cursed wasteland
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#6f6c2d"]) #dark canyon
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#6b1a59"]) #dark mountains
		
	BetterTerrain.update_terrain_cells(tile_map, 0,  pixel_color_dict["#639bff"]) #sea
