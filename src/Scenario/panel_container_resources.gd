extends PanelContainer

@onready var wood_label = $GridContainer/MarginWood/WoodLabel
@onready var stone_label = $GridContainer/MarginStone/StoneLabel
@onready var iron_label = $GridContainer/MarginIron/IronlLabel
@onready var food_label = $GridContainer/MarginFood/FoodLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.call_deferred("connect", "update_player_resources_label", on_update_player_resources_label)
	SignalBus.call_deferred("connect", "next_active_player", on_next_active_player)
	
func on_update_player_resources_label(player : Player) -> void:
	update_resource_labels(player)

func on_next_active_player():
	update_resource_labels(ScenarioDataManager.active_player)

func update_resource_labels(player : Player) -> void:
	update_food_label(player)
	update_iron_label(player)
	update_stone_label(player)
	update_wood_label(player)

func update_stone_label(player : Player) -> void:
	self.stone_label.text = str(player.resources["Stone"])

func update_wood_label(player : Player) -> void:
	self.wood_label.text = str(player.resources["Wood"])

func update_iron_label(player : Player) -> void:
	self.iron_label.text = str(player.resources["Iron"]) 

func update_food_label(player : Player) -> void:
	self.food_label.text = str(player.resources["Food"])
	

