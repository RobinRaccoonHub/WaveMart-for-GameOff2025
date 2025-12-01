extends AudioStreamPlayer2D

const JAZZ_1 = preload("uid://c04wiun6s4vus")
const JAZZ_2 = preload("uid://bywoalfx51bw4")

var current_stream := JAZZ_1

func _ready() -> void:
	set_stream(JAZZ_1)
	play()

func _on_finished() -> void:
	if current_stream == JAZZ_1:
		set_stream(JAZZ_2)
		current_stream = JAZZ_2
		play()
	if current_stream == JAZZ_2:
		set_stream(JAZZ_1)
		current_stream = JAZZ_1
		play()
