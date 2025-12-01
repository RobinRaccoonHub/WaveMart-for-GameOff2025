extends Area2D
class_name GroceryArea

var grocery_name := Data.Grocery.EXIT
var inventory := 5: set = set_inventory
@onready var _timer := Timer.new()

var currently_waiting: Array = []

func _ready() -> void:
	add_child(_timer)
	_timer.wait_time = 1.5
	_timer.timeout.connect(_text_generator)

func _text_generator() -> void:
	var text_indicator: Node2D = preload("res://text_indicator.tscn").instantiate()
	add_child(text_indicator)
	text_indicator.global_position = global_position
	text_indicator.display_text("Stock me!")
	

func _on_body_entered(guest: Guest) -> void:
	if grocery_name == Data.Grocery.EXIT:
		return
	elif guest.grocery_list.has(grocery_name):
		if inventory <= 0:
			currently_waiting.append(guest)
			guest.can_move = false
			guest.waiting_for_inventory = true
		elif inventory >= 1:
			guest.grocery_list.erase(grocery_name)
			inventory -= 1
			guest.change_move()

func set_inventory(new_inventory: int) -> void:
	inventory = clampi(new_inventory, 0, 10)
	if inventory >= 5:
		waiting_clear()
		_timer.stop()
	if inventory <= 1:
		_text_generator()
		_timer.start()

func waiting_clear() -> void:
	if !currently_waiting.is_empty():
		for guest in currently_waiting:
			guest.can_move = true
			guest.waiting_for_inventory = false
			inventory -= 1
