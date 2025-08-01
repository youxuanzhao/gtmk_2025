extends Camera2D
class_name PrimaryCamera

static var instance: PrimaryCamera

@export_category("Camera Configuration")
@export var speed: float = 200.0
@export var camera_scale = 1.0
@export var camera_offset_distance: float = 40.0
@export var random_strength: float = 10.0
@export var shake_fade: float = 5.0
@export var debug_mode: bool = false

var shake_strength: float = 0.0

func _ready() -> void:
	instance = self
	zoom = Vector2(camera_scale, camera_scale)

func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		offset = lerp(offset, random_offset(), 1)
	
	if shake_strength <= 0.9:
		shake_strength = 0.0

func apply_shake(intensity: float) -> void:
	shake_strength = intensity

func random_offset():
	return Vector2(randf_range(-shake_strength, shake_strength),randf_range(-shake_strength, shake_strength))
	
