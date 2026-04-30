extends CharacterBody2D

var draggingDistance
var dir
var dragging
var newPosition = Vector2()
var mouse_in = false

signal clicked(node)

func _unhandled_input(event):
	if event is InputEventMouseButton: #if the detected input is from the mouse
		 #if the mouse is being clicked AND the mouse is in the Area2D
		#i.e. the user has clicked on the shape
		if event.is_pressed() && mouse_in:
			#calculate the distance and direction
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging = true #set dragging to true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging = false
			
	elif event is InputEventMouseMotion:
		if dragging:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir

func _physics_process(delta): #this function is called every frame
	if dragging: #move the shape if dragging is true
		velocity = (newPosition - position) * Vector2(30, 30)
		move_and_slide()

#both of these function set tell the app whether the mouse has entered or exited the area2D
func _on_area_2d_mouse_entered() -> void:
	mouse_in = true
	

func _on_area_2d_mouse_exited() -> void:
	mouse_in = false


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		emit_signal("clicked", self)
