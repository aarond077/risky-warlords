extends Node

signal region_clicked(region_name : String)
signal next_active_player()
signal check_player_index()
signal nation_selected(nation_name : String, player_index : int)
signal remove_region_outlines(region_name : String)
signal remove_sprite(sprite_name : String, region_name : String)
signal draw_capitals_fortress()
signal start_active_player_timer()
signal stop_active_player_timer()
signal pause_active_player_timer()
signal continue_active_player_timer()
signal load_sea_connections(map_name : String)
signal init_battle_phase()
signal init_start_round()
signal create_building(building_name)
signal update_player_resources_label(player : Player)
signal update_player_army_label(player : Player)
signal update_phase_label(phase : String)
signal update_buffs_label(player : Player)
signal update_political_view()
signal create_army_count_labels()
signal show_army_count_labels()
signal hide_army_count_labels()
signal update_army_count_labels()
signal update_banners(target_region : RegionNode, player : Player)
signal update_player_action_points_label(player : Player)
signal show_move_army_container(region_name : String, player : Player)
signal show_battle_container(region_name : String, player : Player)
signal move_army(region_name : String, player : Player)
signal battle_round_finished(attacking_region : RegionNode, defending_region : RegionNode, winning_region : RegionNode, losing_region : RegionNode, attacker_loss : int, defender_loss : int)
signal next_battle_round(attacking_region : RegionNode, defending_region : RegionNode)
signal region_defeated(winning_region : RegionNode, losing_region : RegionNode)
signal set_physical_view()
signal set_political_view()
signal getCurrentView()
signal game_end()
