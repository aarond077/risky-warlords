extends Node

class_name BuildingFactory

static func create_building(building_name : String, nation: String, position : Vector2, region_name : String) -> RemovableSprite:
	if building_name == "Festung":
		return create_fortress(nation, position, region_name)
	elif building_name == "Heiligtum":
		return create_sanctuary(nation, position, region_name)
	elif building_name == "Wachturm":
		return create_tower(nation, position, region_name)
	elif building_name == "Forschungsgebäude":
		return create_research_center(nation, position, region_name)
	elif building_name == "Ressourcengebäude":
		return create_resource_building(position, region_name)
	else:
		print("ERROR: BUILDING NAME NOT FOUND")
		return null
	
		
static func create_resource_building(position, region_name):
	var active_region : RegionNode = ScenarioDataManager.active_region
	if active_region.resource == "Wood":
		return create_lumberjack_hut(position, region_name)
	elif active_region.resource == "Stone":
		return create_quarry(position, region_name)
	elif active_region.resource == "Iron":
		return create_mine(position, region_name)
	elif active_region.resource == "Null":
		return null
	else:
		print("ERROR: RESOURCE NOT FOUND")
	return null;
		
	
static func create_fortress(nation: String, position : Vector2, region_name : String) -> RemovableSprite:
	var fortress : RemovableSprite = RemovableSprite.new()
	fortress.position = position
	fortress.sprite_name = "Festung"
	fortress.region_name = region_name
	fortress.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	fortress.texture = ResourceLoader.load(
		"res://assets/Buildings/Festung" + nation + ".png")
	return fortress

static func create_tower(nation: String, position : Vector2, region_name : String)-> RemovableSprite:
	var tower : RemovableSprite = RemovableSprite.new()
	tower.position = position
	tower.sprite_name = "Wachturm"
	tower.region_name = region_name
	tower.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	tower.texture = ResourceLoader.load(
		"res://assets/Buildings/Wachturm"+ nation + ".png")
	return tower

static func create_research_center(nation: String, position : Vector2, region_name : String)-> RemovableSprite:
	var research_center : RemovableSprite = RemovableSprite.new()
	research_center.position = position
	research_center.sprite_name = "Forschungsgebäude"
	research_center.region_name = region_name
	research_center.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	research_center.texture = ResourceLoader.load(
		"res://assets/Buildings/Forschungsstation" + nation + ".png")
	return research_center

static func create_sanctuary(nation: String, position : Vector2, region_name : String)-> RemovableSprite:
	var sanctuary : RemovableSprite = RemovableSprite.new()
	sanctuary.position = position
	sanctuary.sprite_name = "Sanctuary"
	sanctuary.region_name = region_name
	sanctuary.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	sanctuary.texture = ResourceLoader.load(
		"res://assets/Buildings/Heiligtum" + nation + ".png")
	return sanctuary


static func create_mine(position : Vector2, region_name : String) -> RemovableSprite:
	var mine : RemovableSprite = RemovableSprite.new()
	mine.position = position
	mine.sprite_name = "Mine"
	mine.region_name = region_name
	mine.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	mine.texture = ResourceLoader.load(
		"res://assets/Buildings/Mine.png")
	return mine

static func create_lumberjack_hut(position : Vector2, region_name : String) -> RemovableSprite:
	var lumberjack_hut : RemovableSprite = RemovableSprite.new()
	lumberjack_hut.position = position
	lumberjack_hut.sprite_name = "Holzfällerhütte"
	lumberjack_hut.region_name = region_name
	lumberjack_hut.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	lumberjack_hut.texture = ResourceLoader.load(
		"res://assets/Buildings/LumberjackHut.png")
	return lumberjack_hut

static func create_quarry(position : Vector2, region_name : String) -> RemovableSprite:
	var quarry : RemovableSprite = RemovableSprite.new()
	quarry.position = position
	quarry.sprite_name = "Steinbruch"
	quarry.region_name = region_name
	quarry.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	quarry.texture = ResourceLoader.load(
		"res://assets/Buildings/Quarry.png")
	return quarry
