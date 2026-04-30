extends Camera2D

var dragStartMousePosition = Vector2.ZERO
var dragStartCameraPosition = Vector2.ZERO
var isDragging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ZoomSpeed = Vector2(0.1, 0.1)
	 
	if Input.is_action_just_released("Scroll Up"):
		zoom += ZoomSpeed
	
	if Input.is_action_just_released("Scroll Down"):
		zoom -= ZoomSpeed
	
	if !isDragging && Input.is_action_just_pressed("Pan Camera"):
		dragStartMousePosition = get_viewport().get_mouse_position()
		dragStartCameraPosition = position
		isDragging = true
	
	if isDragging && Input.is_action_just_released("Pan Camera"):
		isDragging = false
	
	if isDragging:
		var moveVector = get_viewport().get_mouse_position() - dragStartMousePosition
		position = dragStartCameraPosition - moveVector * 1/zoom.x
