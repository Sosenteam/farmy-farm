extends CanvasLayer

@onready var time_label = $Control/Time
@onready var date_label = $Control/Date

const TICKS_PER_DAY = 960
const TICKS_PER_HOUR = TICKS_PER_DAY/24
const MONTHS = ["January", "Feburary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
var hour: int
var day: int
var month: int
var year: int
var total_ticks: int = 0

func _ready() -> void:
	var starttime = Time.get_datetime_dict_from_system()
	
	year = starttime["year"]
	month = starttime["month"] - 1
	day = starttime["day"]
	hour = starttime["hour"]
	
	total_ticks = hour * TICKS_PER_HOUR
	
	Global.on_tick.connect(on_tick)
	update_ui()

func on_tick() -> void:
	total_ticks += 1

	hour = (total_ticks / TICKS_PER_HOUR) % 24
	
	# When 960 ticks pass, a full day has ended
	if total_ticks >= TICKS_PER_DAY:
		total_ticks = 0
		advance_day()
	
	update_ui()

func advance_day() -> void:
	day += 1
	
	if day > 30: #every motnh is 30 for simplicity
		day = 1
		month += 1
		if month > 11:
			month = 0
			year += 1

func update_ui() -> void:
	# Date Display
	date_label.text = "%s %d, %d" % [MONTHS[month], day, year]
	
	# Time Display (12-hour format)
	var display_hour = hour % 12
	if display_hour == 0: display_hour = 12
	var am_pm = "AM" if hour < 12 else "PM"
	
	time_label.text = "%d:00 %s" % [display_hour, am_pm]
