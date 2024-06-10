extends Node

class_name DataFileManager

static func import_file(filepath : String):
	var file = FileAccess.open(filepath, FileAccess.READ)
	if file != null:
		return JSON.parse_string(file.get_as_text().replace("_", " "))
	else:
		print("Failed to open file:" + filepath)
		return null	
