extends Node
 
var file : FileAccess     # File object opened by the FileAccess library
var file_path : String     # File path to the requested file
var password : String     # Password for file encryption and decryption
 
# Fill the file data in the local variables
func initialize(init_path : String, init_password : String) -> void:
	file_path = init_path
	password = init_password
 
# Clear the file data in the local variables
func clear() -> void:
	file = null
	file_path = ""
	password = ""

# Open a file encrypted with the given password
func open_file(access : FileAccess.ModeFlags) -> int:
	# Try opening an encrypted file with write access
	file = FileAccess.open_encrypted_with_pass(file_path, access, password)	 
	
	print(FileAccess.file_exists(file_path))
	# Return the assigned file index (handle)
	return FileAccess.get_open_error() if (file == null) else OK	 
# Open a file encrypted with the given password
func close_file() -> void:
	file = null
	
# Serialize the object's properties and write them to the file with the given ID
func serialize(object) -> void:
	object.serialize(file) 
# Read the object's properties from the given file and deserialize them
func deserialize(object) -> void:
	object.deserialize(file)
