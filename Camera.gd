extends Camera3D

# member variables here, example:
# var a=2
# var b="textvar"
@export var flyspeed= 2.0
var view_sensitivity = 0.3
var mousedifference = Vector3()
var yaw = 0
var pitch = 0

func _ready():
	# Initialization here
	self.set_process_input(true)
	self.set_process(true)
	#set mouse position

func _enter_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if(event is InputEventKey):
		if(event.keycode == KEY_ESCAPE):
			self.get_tree().quit()
	
	if(event is InputEventMouseMotion):
		yaw = fmod(yaw  - event.relative.x * view_sensitivity , 360)
		pitch = max(min(pitch - event.relative.y * view_sensitivity, 90), -90)
		self.rotation.x = deg_to_rad(pitch);
		self.rotation.y = deg_to_rad(yaw);

func _process(delta):
	#mouse movement
	if Input.is_action_just_pressed("ui_focus_next"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("ui_page_up"):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (!((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))) else Window.MODE_WINDOWED
	if(Input.is_key_pressed(KEY_W)):
		self.set_position(self.get_position() - get_global_transform().basis*Vector3(0,0,1) * flyspeed * delta)
	if(Input.is_key_pressed(KEY_S)):
		self.set_position(self.get_position() - get_global_transform().basis*Vector3(0,0,1) * flyspeed * -delta)
	if(Input.is_key_pressed(KEY_A)):
		self.set_position(self.get_position() - get_global_transform().basis*Vector3(1,0,0) * flyspeed * delta)
	if(Input.is_key_pressed(KEY_D)):
		self.set_position(self.get_position() - get_global_transform().basis*Vector3(1,0,0) * flyspeed * -delta)
	if(Input.is_key_pressed(KEY_E)):
		translate(Vector3.UP*flyspeed*delta)
	if(Input.is_key_pressed(KEY_Q)):
		translate(Vector3.DOWN*flyspeed*delta)
