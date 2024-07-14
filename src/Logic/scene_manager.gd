extends Node

# A collection of scenes in the game. Scenes are added through the Inspector panel
@export var scenes : Dictionary = {}

# Alias of the currently selected scene
var current_scene_name : String = ""
	
# Description: Find the initial scene as defined in the project settings
func _ready() -> void:
	var main_scene : StringName = ProjectSettings.get_setting("application/run/main_scene")
	#current_scene_name = scenes.find_key(main_scene)
	print(current_scene_name)
 


# Description: Add a new scene to the scene collection
# Parameter sceneAlias: The alias used for finding the scene in the collection
# Parameter scenePath: The full path to the scene file in the file system
func add_scene(scene_name : String, scene_path : String) -> void:
	scenes[scene_name] = scene_path
	
# Description: Remove an existing scene from the scene collection
# Parameter sceneAlias: The scene alias of the scene to remove from the collection
func remove_scene(scene_name : String) -> void:
	scenes.erase(scene_name)
	
# Description: Switch to the requested scene based on its alias
# Parameter sceneAlias: The scene alias of the scene to switch to
func switch_scene(scene_name : String) -> void:

	current_scene_name = scene_name
	get_tree().change_scene_to_file(scenes[scene_name])
 
# Description: Restart the current scene
func restart_scene() -> void:
	get_tree().reload_current_scene()
	
# Description: Quit the game
func quit_game() -> void:
	get_tree().quit()
	
# Description: Return the number of scenes in the collection
func get_scenes_size() -> int:
	return scenes.size()
	
# Description: Returns the alias of the current scene
func get_current_scene_name() -> String:
	return current_scene_name
