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
	set_process_input(true)
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

var speed = 50
var offset = Vector3()

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed(): # zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				scrollup = true
				# call the zoom function
	        # zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				scrolldown = true

var scrollup = false
var scrolldown = false
func _physics_process(delta):
	offset = Vector3(0, 0, 0)
	var pos = global_transform.origin
	var target = pos + Vector3(0, -1, -1).normalized()
	var up = Vector3(0, 1, 0)
	look_at_from_position(pos, target, up)

	if Input.is_action_pressed("ui_left"): # ui_left
		offset.x -= 1
	if Input.is_action_pressed("ui_right"): #ui_right
		offset.x += 1
	if Input.is_action_pressed("ui_up"): #ui_up
		offset.y += 1
		offset.z -= 1
	if Input.is_action_pressed("ui_down"): #ui_down
		offset.y -= 1
		offset.z += 1
	if Input.is_action_pressed("scroll_out") or scrolldown == true:
		offset.z -= 8
	if Input.is_action_pressed("scroll_in") or scrollup == true:
		offset.z += 8
	scrollup = false
	scrolldown = false
#	if event is InputEventMouseButton:
#		if event.is_pressed(): # zoom in
#			if event.button_index == BUTTON_WHEEL_UP:
#				zoom_pos = get_global_mouse_position()
#				# call the zoom function
#	        # zoom out
#			if event.button_index == BUTTON_WHEEL_DOWN:
#				zoom_pos = get_global_mouse_position()
#				#call the zoom function
	
	
	#offset = offset.normalized()
	offset = offset * speed * delta
	self.translate(offset)

	# rotation
	# var pos = global_transform.origin
	var target2 = pos + Vector3(0, -1, -1).normalized()

	# look_at_from_position(pos, target2, up)
	# Turn a little up or down
	#var t = transform
	#t.basis = Basis(t.basis[0], deg2rad(angle_v_adjust))*t.basis
	#transform = t
	# pos = target + delta
	

