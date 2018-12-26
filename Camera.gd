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

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

var speed = 20
var offset = Vector3()

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
	offset = offset * speed * delta
	self.translate(offset)