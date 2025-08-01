extends TextureRect
class_name TrackUnit

var has_triggered: bool = false

var detect_area: Area2D

var on_hover = false

func _init() -> void:
	expand_mode = EXPAND_FIT_WIDTH
	custom_minimum_size = Vector2(40.0,40.0)
func _ready() -> void:
	# Initialize the track unit, set up visuals, etc.
	# This is where you would set the texture or any other properties for the track unit.
	texture = preload("res://icon.svg")  # Example texture path
	mouse_entered.connect(_on_mouse_enter)
	mouse_exited.connect(_on_mouse_exit)

func _on_mouse_enter() -> void:
	on_hover = true
	material = preload("res://outline.tres")

func _on_mouse_exit() -> void:
	on_hover = false
	material = null  # Reset the material to remove the outline
	

func _effect() -> void:
	# This function can be used to apply effects or actions when the track unit is activated.
	# For example, you might want to change the texture or trigger an animation.
	print("track effect")
