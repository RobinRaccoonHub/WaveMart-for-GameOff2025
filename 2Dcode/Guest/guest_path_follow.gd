extends PathFollow2D
class_name GuestPathFollow

@onready var guest: Guest = null: set = set_guest
@onready var guest_speed = randf_range(60.0, 80.0)
@onready var _collision_timer = Timer.new()


var collided_with_guest := false

func _ready() -> void:
	add_child(_collision_timer)
	_collision_timer.wait_time = 6.0
	_collision_timer.one_shot = true

func _physics_process(delta: float) -> void:
	if guest == null:
		return
	if guest.checkout_queue:
		if guest.ray_cast_front.is_colliding() or guest.ray_cast_left.is_colliding() or guest.ray_cast_right.is_colliding():
			return
	if guest.can_move:
		progress += guest_speed * delta

func set_guest(new_guest: Guest) -> void:
	guest = new_guest
	guest.tree_exited.connect(queue_free)
