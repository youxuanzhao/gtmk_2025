extends TextureRect
class_name AvailableUnit

var on_hover: bool = false
var is_dragging: bool = false
var indicator: Sprite2D

signal dropped

func _ready() -> void:
	# Initialize the track unit, set up visuals, etc.
	# This is where you would set the texture or any other properties for the track unit.
	mouse_entered.connect(_on_mouse_enter)
	mouse_exited.connect(_on_mouse_exit)

func _on_mouse_enter() -> void:
	on_hover = true
	material = preload("res://outline.tres")

func _on_mouse_exit() -> void:
	on_hover = false
	material = null  # Reset the material to remove the outline

func _process(delta: float) -> void:
	if is_dragging and indicator:
		var mouse_pos = get_local_mouse_position()
		indicator.position = mouse_pos  # Center the unit under the mouse cursor
		print(indicator.position)
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			is_dragging = false
			dropped.emit()  # Emit the dropped signal when dragging stops
			if indicator:
				indicator.queue_free()  # Remove the indicator when dragging stops
			print("Dragging stopped")
	
func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if on_hover:
			# Handle the click event here, e.g., trigger an action or select the unit
			print("AvailableUnit clicked")
			# You can call a method to handle the click action
			indicator = Sprite2D.new()
			indicator.texture = preload("res://icon.svg")  # Example texture path
			indicator.scale = Vector2(0.5, 0.5)  # Adjust scale as needed
			indicator.modulate = Color(1, 1, 1, 0.5)  # Semi-transparent yellow
			add_child(indicator)
			is_dragging = true
			
