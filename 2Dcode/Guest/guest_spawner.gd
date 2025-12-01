extends Node2D
class_name GuestSpawner

@onready var spawn_interval := 10.0
@onready var guest_scene := preload("res://2Dcode/Guest/guests.tscn")

@onready var guest_pathing: Floor = %GuestPath
@onready var spawn_area := %SpawnArea
@onready var initial_area := %InitialArea
@onready var eggs_area: GroceryArea = %EggsArea
@onready var dairy_area: GroceryArea = %DairyArea
@onready var meat_area: GroceryArea = %MeatArea
@onready var produce_area: GroceryArea = %ProduceArea
@onready var baking_area: GroceryArea = %BakingArea
@onready var snacks_area: GroceryArea = %SnacksArea
@onready var drinks_area: GroceryArea = %DrinksArea
@onready var exit_area: GroceryArea = %ExitArea
@onready var audio_player: AudioStreamPlayer2D = %AudioStreamPlayer2D

@onready var grocery_locations: Dictionary = {
	Data.Grocery.EGGS : eggs_area,
	Data.Grocery.DAIRY : dairy_area,
	Data.Grocery.MEAT : meat_area,
	Data.Grocery.PRODUCE : produce_area,
	Data.Grocery.BAKING : baking_area,
	Data.Grocery.SNACKS : snacks_area,
	Data.Grocery.DRINKS : drinks_area,
	Data.Grocery.EXIT : exit_area
}

var _timer := Timer.new()

func _ready() -> void:
	add_child(_timer)
	_timer.timeout.connect(spawn_guest)
	_timer.wait_time = spawn_interval
	_timer.start()
	for key in grocery_locations:
		var value = grocery_locations[key]
		value.grocery_name = key

func spawn_guest() -> void:
	var guest_path := Path2D.new()
	var guest_path_follow := GuestPathFollow.new()
	guest_path.top_level = true
	add_child(guest_path)
	guest_path.curve = Curve2D.new()
	guest_path.add_child(guest_path_follow)
	var guest: Guest = guest_scene.instantiate()
	guest.my_spawner = self
	audio_player.play()
	for grocery_index in randi_range(1, 4):
		guest.possible_items.shuffle()
		var possible_grocery = guest.possible_items.pop_front()
		guest.grocery_list.append(possible_grocery)
	guest.grocery_list.append(Data.Grocery.EXIT)
	var all_groceries := guest_pathing.find_path_to_target(spawn_area, initial_area)
	var previous_location := initial_area
	for grocery in guest.grocery_list:
		var current_grocery_location = grocery_locations[grocery]
		var path_to_groceries = guest_pathing.find_path_to_target(previous_location, current_grocery_location)
		previous_location = current_grocery_location
		all_groceries += path_to_groceries
	for point in all_groceries:
		guest_path.curve.add_point(point)
	guest_path_follow.add_child(guest)
	guest_path_follow.guest = guest
	_timer.wait_time = move_toward(_timer.wait_time, 4.0, 0.25)
	Happiness.total_guests += 1
	
