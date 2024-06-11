extends Node

signal region_clicked(region_name : String)
signal next_active_player()
signal nation_selected(nation_name : String, player_index : int)
signal remove_region_outlines(region_name : String)
signal remove_sprite(sprite_name : String, region_name : String)
signal start_active_player_timer()
signal create_building(building_name)
signal set_physical_view()
signal set_political_view()
