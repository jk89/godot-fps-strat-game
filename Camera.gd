extends Camera

enum CameraMode {
	UNIT_TRACK,
	ISOMETRIC
}

var cameraMode = CameraMode.ISOMETRIC
var unitToTrack = null

func trackUnit(unit):
	unitToTrack = unit
	pass

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 700
var offset = Vector3()
var current_pos = Vector3()
# var target_pos = Vector3()
var smooth_camera_pos = Vector3()

func _physics_process(delta):
	offset = Vector3(0, 0, 0)
	if Input.is_action_pressed("ui_left"): # ui_left
		offset.x -= 1
	if Input.is_action_pressed("ui_right"): #ui_right
		offset.x += 1
	if Input.is_action_pressed("ui_up"): #ui_up
		offset.z -= 1
	if Input.is_action_pressed("ui_down"): #ui_down
		offset.z += 1
	offset = offset.normalized()
	self.translate(offset)
	
	
	#var target_pos = get_parent().get_transform().origin
	#var parent_basis = get_parent().get_transform().basis
	#target_pos += parent_basis.z * offset.z
	#target_pos += parent_basis.y * offset.y
	#target_pos += parent_basis.x * offset.x

	#smooth_camera_pos = smooth_camera_pos.linear_interpolate(target_pos, speed * delta)
	#set_translation(smooth_camera_pos)

	#offset = offset
	#current_pos = self.get_camera_transform()
	#target_pos = current_pos + offset
	#smooth_camera_pos = smooth_camera_pos.linear_interpolate(target_pos, speed * delta)
	#set_translation(target_pos)
