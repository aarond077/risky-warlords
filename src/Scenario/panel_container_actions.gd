extends PanelContainer



@onready var create_building_menu_button = $VBoxContainer/MarginContainer2/GridContainer/GebaeudeErrichten

# Called when the node enters the scene tree for the first time.
func _ready():
	create_building_menu_button.get_popup().id_pressed.connect(_on_item_menu_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_item_menu_pressed(id: int):
	var building_name = create_building_menu_button.get_popup().get_item_text(id)
	SignalBus.call_deferred("emit_signal", "create_building", building_name)
	
	
