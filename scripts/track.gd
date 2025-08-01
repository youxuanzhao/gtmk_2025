extends PanelContainer
class_name Track

var enabled: bool = false
var level:int = 0
var track_name:String = ""
var h_box: HBoxContainer
var cursor: Sprite2D
var timer: Timer
var upgrade_button: Button

func _ready() -> void:
	# material = preload("res://blink.tres")
	# material.set_shader_parameter("blink_modifier", 1.0)
	set_h_size_flags(0)
	add_theme_stylebox_override("panel", preload("res://track_ph.tres"))
	custom_minimum_size.y = 40
	h_box = HBoxContainer.new()
	add_child(h_box)
	for i in level:
		h_box.add_child(TrackUnit.new())
	cursor = Sprite2D.new()
	cursor.texture = preload("res://placeholder2.png")
	cursor.scale = Vector2(0.125, 1.25)
	cursor.centered = false
	add_child(cursor)
	timer = Timer.new()
	timer.timeout.connect(on_timer_timeout)
	timer.wait_time = level * TrackManager.instance.time_per_unit
	if level > 0:
		timer.autostart = true
	add_child(timer)
	upgrade_button = Button.new()
	upgrade_button.text = "+"
	upgrade_button.size_flags_horizontal = SIZE_SHRINK_END
	upgrade_button.pressed.connect(upgrade)
	add_child(upgrade_button)

func upgrade() -> void:
	if level < TrackManager.instance.max_level_per_track:
		if level == 0:
			enabled = true  # Enable the track if it was previously disabled
			if TrackManager.instance.get_child_count() < TrackManager.instance.max_tracks:
				TrackManager.instance.add_child(Track.new())
		level += 1
		h_box.add_child(TrackUnit.new())
		for i in h_box.get_children():
			if i is TrackUnit:
				i.has_triggered = false  # Remove the old units
		timer.wait_time = level * TrackManager.instance.time_per_unit
		timer.start()


func _process(delta: float) -> void:
	if level < TrackManager.instance.max_level_per_track:
		upgrade_button.visible = true
	else:
		upgrade_button.visible = false
	if enabled:
		var percent = (timer.wait_time - timer.time_left) / timer.wait_time
		cursor.visible = true
		cursor.position.x = percent * h_box.size.x
		var count = 0
		for i in h_box.get_children():
			if i is TrackUnit and count == round(percent/(1.0/level)) and !i.has_triggered:
				i._effect()  # Call the effect method to apply any effects
				i.has_triggered = true  # Mark this unit as triggered
			count+=1
	else:
		cursor.visible = false

func on_timer_timeout() -> void:
	for i in h_box.get_children():
		if i is TrackUnit:
			i.has_triggered = false  # Reset the trigger state for all units
	# This function is called when the timer reaches zero.
	# You can implement logic here to handle what happens when the track completes.
	# print("Track completed!")
	# For example, you might want to trigger an event or update the UI.
