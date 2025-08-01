extends VBoxContainer
class_name TrackManager

static var instance: TrackManager

@export_category("Track Configuration")
@export var max_tracks: int = 5
@export var max_level_per_track: int = 6
@export var unlock_cost: Array[int] = [10,20,40,60]
@export var upgrade_cost: Array[int] = [2, 5, 8, 10, 15]
@export var time_per_unit: float = 1.0

func _ready() -> void:
	instance = self
	# Initialize the track manager, load tracks, etc.
	# This is where you would set up your tracks and any necessary data structures.
	var initial_track = Track.new()
	initial_track.level = 3
	initial_track.enabled = true
	add_child(initial_track)

	var new_track = Track.new()
	add_child(new_track)
