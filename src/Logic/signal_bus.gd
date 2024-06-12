extends Node

signal region_clicked(region_name : String)
signal next_active_player()
signal nation_selected(nation_name : String, player_index : int)
signal remove_region_outlines(region_name : String)
signal remove_sprite(sprite_name : String, region_name : String)
signal draw_capitals_fortress()
signal start_active_player_timer()
signal create_building(building_name)
signal update_player_resources_label(player : Player)
signal update_player_army_label(player : Player)
signal set_physical_view()
signal set_political_view()
