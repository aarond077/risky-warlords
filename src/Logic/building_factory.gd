extends Node

class_name BuildingFactory

	
static func create_fortress_humans(position : Vector2, region_name : String) -> RemovableSprite:
	var fortress : RemovableSprite = RemovableSprite.new()
	fortress.position = position
	fortress.sprite_name = "Fortress"
	fortress.region_name = region_name
	fortress.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	fortress.texture = ResourceLoader.load(
		"res://assets/Buildings/FestungMenschen.png")
	return fortress

static func create_tower_humans(position : Vector2, region_name : String)-> RemovableSprite:
	var tower : RemovableSprite = RemovableSprite.new()
	tower.position = position
	tower.sprite_name = "Tower"
	tower.region_name = region_name
	tower.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	tower.texture = ResourceLoader.load(
		"res://assets/Buildings/WachturmMenschen.png")
	return tower

static func create_research_center_humans(position : Vector2, region_name : String)-> RemovableSprite:
	var research_center : RemovableSprite = RemovableSprite.new()
	research_center.position = position
	research_center.sprite_name = "ResearchCenter"
	research_center.region_name = region_name
	research_center.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	research_center.texture = ResourceLoader.load(
		"res://assets/Buildings/ForschungslaborMenschen.png")
	return research_center

static func create_sanctuary_humans(position : Vector2, region_name : String)-> RemovableSprite:
	var sanctuary : RemovableSprite = RemovableSprite.new()
	sanctuary.position = position
	sanctuary.sprite_name = "Sanctuary"
	sanctuary.region_name = region_name
	sanctuary.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	sanctuary.texture = ResourceLoader.load(
		"res://assets/Buildings/HeiligtumVonDessus.png")
	return sanctuary

static func create_fortress_dwarves(position : Vector2, region_name : String) -> RemovableSprite:
	var fortress : RemovableSprite = RemovableSprite.new()
	fortress.position = position
	fortress.sprite_name = "Fortress"
	fortress.region_name = region_name
	fortress.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	fortress.texture = ResourceLoader.load(
		"res://assets/Buildings/FestungZwerge.png")
	return fortress

static func create_tower_dwarves(position : Vector2, region_name : String) -> RemovableSprite:
	var tower : RemovableSprite = RemovableSprite.new()
	tower.position = position
	tower.sprite_name = "Tower"
	tower.region_name = region_name
	tower.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	tower.texture = ResourceLoader.load(
		"res://assets/Buildings/WachturmZwerge.png")
	return tower

static func create_research_center_dwarves(position : Vector2, region_name : String) -> RemovableSprite:
	var research_center : RemovableSprite = RemovableSprite.new()
	research_center.position = position
	research_center.sprite_name = "ResearchCenter"
	research_center.region_name = region_name
	research_center.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	research_center.texture = ResourceLoader.load(
		"res://assets/Buildings/ForschungsstationZwerge.png")
	return research_center

static func create_sanctuary_dwarves(position : Vector2, region_name : String) -> RemovableSprite:
	var sanctuary : RemovableSprite = RemovableSprite.new()
	sanctuary.position = position
	sanctuary.sprite_name = "Sanctuary"
	sanctuary.region_name = region_name
	sanctuary.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	sanctuary.texture = ResourceLoader.load(
		"res://assets/Buildings/HeiligtumVonBrann.png")
	return sanctuary

static func create_fortress_orcs(position : Vector2, region_name : String) -> RemovableSprite:
	var fortress : RemovableSprite = RemovableSprite.new()
	fortress.position = position
	fortress.sprite_name = "Fortress"
	fortress.region_name = region_name
	fortress.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	fortress.texture = ResourceLoader.load(
		"res://assets/Buildings/FestungOrks.png")
	return fortress

static func create_tower_orcs(position : Vector2, region_name : String) -> RemovableSprite:
	var tower : RemovableSprite = RemovableSprite.new()
	tower.position = position
	tower.sprite_name = "Tower"
	tower.region_name = region_name
	tower.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	tower.texture = ResourceLoader.load(
		"res://assets/Buildings/WachturmOrks.png")
	return tower

static func create_research_center_orcs(position : Vector2, region_name : String) -> RemovableSprite:
	var research_center : RemovableSprite = RemovableSprite.new()
	research_center.position = position
	research_center.sprite_name = "ResearchCenter"
	research_center.region_name = region_name
	research_center.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	research_center.texture = ResourceLoader.load(
		"res://assets/Buildings/ForschungsstationOrks.png")
	return research_center

static func create_sanctuary_orcs(position : Vector2, region_name : String) -> RemovableSprite:
	var sanctuary : RemovableSprite = RemovableSprite.new()
	sanctuary.position = position
	sanctuary.sprite_name = "Sanctuary"
	sanctuary.region_name = region_name
	sanctuary.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	sanctuary.texture = ResourceLoader.load(
		"res://assets/Buildings/HeiligtumVonAzor.png")
	return sanctuary

static func create_fortress_elves(position : Vector2, region_name : String) -> RemovableSprite:
	var fortress : RemovableSprite = RemovableSprite.new()
	fortress.position = position
	fortress.sprite_name = "Fortress"
	fortress.region_name = region_name
	fortress.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	fortress.texture = ResourceLoader.load(
		"res://assets/Buildings/FestungElfen.png")
	return fortress

static func create_tower_elves(position : Vector2, region_name : String) -> RemovableSprite:
	var tower : RemovableSprite = RemovableSprite.new()
	tower.position = position
	tower.sprite_name = "Tower"
	tower.region_name = region_name
	tower.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	tower.texture = ResourceLoader.load(
		"res://assets/Buildings/WachturmElfen.png")
	return tower

static func create_research_center_elves(position : Vector2, region_name : String) -> RemovableSprite:
	var research_center : RemovableSprite = RemovableSprite.new()
	research_center.position = position
	research_center.sprite_name = "ResearchCenter"
	research_center.region_name = region_name
	research_center.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	research_center.texture = ResourceLoader.load(
		"res://assets/Buildings/ForschungsstationElfen.png")
	return research_center

static func create_sanctuary_elves(position : Vector2, region_name : String) -> RemovableSprite:
	var sanctuary : RemovableSprite = RemovableSprite.new()
	sanctuary.position = position
	sanctuary.sprite_name = "Sanctuary"
	sanctuary.region_name = region_name
	sanctuary.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	sanctuary.texture = ResourceLoader.load(
		"res://assets/Buildings/HeiligtumVonSephra.png")
	return sanctuary

static func create_mine(position : Vector2, region_name : String) -> RemovableSprite:
	var mine : RemovableSprite = RemovableSprite.new()
	mine.position = position
	mine.sprite_name = "Mine"
	mine.region_name = region_name
	mine.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	mine.texture = ResourceLoader.load(
		"res://assets/Buildings/Mine.png")
	return mine

static func create_lumberjack_hut(position : Vector2, region_name : String) -> RemovableSprite:
	var lumberjack_hut : RemovableSprite = RemovableSprite.new()
	lumberjack_hut.position = position
	lumberjack_hut.sprite_name = "LumberjackHut"
	lumberjack_hut.region_name = region_name
	lumberjack_hut.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	lumberjack_hut.texture = ResourceLoader.load(
		"res://assets/Buildings/LumberjackHut.png")
	return lumberjack_hut

static func create_quarry(position : Vector2, region_name : String) -> RemovableSprite:
	var quarry : RemovableSprite = RemovableSprite.new()
	quarry.position = position
	quarry.sprite_name = "Quarry"
	quarry.region_name = region_name
	quarry.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	quarry.texture = ResourceLoader.load(
		"res://assets/Buildings/Quarry.png")
	return quarry
