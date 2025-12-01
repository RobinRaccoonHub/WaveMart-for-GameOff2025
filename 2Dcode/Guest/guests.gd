extends CharacterBody2D
class_name Guest

var possible_items: Array = [Data.Grocery.EGGS,
	Data.Grocery.DAIRY, 
	Data.Grocery.MEAT, 
	Data.Grocery.PRODUCE, 
	Data.Grocery.BAKING, 
	Data.Grocery.SNACKS, 
	Data.Grocery.DRINKS
]

var grocery_list : Array = []
var purchased: Array = []

@onready var ray_cast_front: RayCast2D = %RayCastFront
@onready var ray_cast_left: RayCast2D = %RayCastLeft
@onready var ray_cast_right: RayCast2D = %RayCastRight


@onready var _timer = Timer.new()
@onready var _collision_timer = Timer.new()
@onready var trash_scene := preload("res://2Dcode/Trash/trash.tscn")

@onready var happiness := 500.0: set = set_happiness
@onready var ramping_anger := 0.01

var my_spawner = null
var can_move := true
var checkout_queue := false
var waiting_for_checkout := false
var waiting_for_inventory := false

func _ready() -> void:
	add_child(_timer)
	_timer.wait_time = 5.0
	_timer.one_shot = true
	add_child(_collision_timer)
	_collision_timer.wait_time = 5.0
	_collision_timer.one_shot = true
	_timer.timeout.connect(change_move)

func set_happiness(new_happiness: float) -> void:
	happiness = new_happiness
	if happiness <= 1.0:
		var text_generator = preload("res://text_indicator.tscn").instantiate()
		Happiness.add_child(text_generator)
		text_generator.global_position = global_position
		text_generator.display_text("Let me talk to your manager!")
		Happiness.guest_complaints += 1
		left()

func _physics_process(delta: float) -> void:
	if waiting_for_checkout:
		happiness -= ramping_anger * delta
		ramping_anger += 0.01
		return
	if waiting_for_inventory:
		happiness -= ramping_anger * delta
		ramping_anger += 0.01
		return
	if checkout_queue:
		if ray_cast_front.is_colliding() or ray_cast_left.is_colliding() or ray_cast_right.is_colliding():
			happiness -= ramping_anger * delta
			ramping_anger += 0.005
			return
		elif !ray_cast_front.is_colliding():
			can_move = true

func change_move() -> void:
	can_move = not can_move
	if !can_move:
		var trash_prob = randi_range(1, 4)
		if trash_prob == 1:
			var trash = trash_scene.instantiate()
			trash.created_by = self
			my_spawner.add_child(trash)
			trash.global_position = global_position
		_timer.start()

func left() -> void:
	Happiness.update_happiness(happiness)
	queue_free()
