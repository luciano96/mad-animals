extends RigidBody2D

enum ANIMAL_STATE { READY, DRAG, RELEASE }

@onready var stretch_sound = $Stretch
@onready var arrow = $Arrow
@onready var launch = $Launch
@onready var kick = $Kick

const DRAG_LIM_MAX: Vector2 = Vector2(30.5, 30.5)
const DRAG_LIM_MIN: Vector2 = Vector2(-30.5, - 30.5)
const IMPULSE_MULT: float = 30.0
const IMPULSE_MAX: float = 1200.0

var _state: ANIMAL_STATE = ANIMAL_STATE.READY
var _start_pos: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _prev_dragged_vector: Vector2 = Vector2.ZERO
var _arrow_scale_x: float = 0.0
var _arrow_scale_y: float = 0.0
var _last_colision_count: int = 0

func _ready():
	_arrow_scale_x = arrow.scale.x
	_arrow_scale_y = arrow.scale.y
	arrow.hide()
	_start_pos = position

func _physics_process(delta):
	update(delta)

func get_impulse() -> Vector2:
	return _dragged_vector * -1 * IMPULSE_MULT

func set_release() -> void:
	arrow.hide()
	freeze = false
	apply_central_impulse(get_impulse())
	launch.play()
	SignalManager.on_attempt_made.emit()

func set_drag() -> void:
	_drag_start = get_global_mouse_position()
	arrow.show()

func set_new_state(new_state: ANIMAL_STATE) -> void:
	_state = new_state
	match _state:
		ANIMAL_STATE.RELEASE:
			set_release()
		ANIMAL_STATE.DRAG:
			set_drag()

func detect_release() -> bool:
	if _state == ANIMAL_STATE.DRAG:
		if Input.is_action_just_released("drag"):
			set_new_state(ANIMAL_STATE.RELEASE)
			return true
	return false

func scale_arrow() -> void:
	var l = get_impulse().length()
	var perc = l / IMPULSE_MAX 
	var perc_Y = l / IMPULSE_MAX / 5
	arrow.scale.x = (_arrow_scale_x * perc) + _arrow_scale_x
	arrow.scale.y = (_arrow_scale_y * perc_Y) + _arrow_scale_y
	arrow.rotation = (_start_pos - position).angle()

func play_stretch_sound() -> void:
	if (_prev_dragged_vector - _dragged_vector).length() > 0:
		if !stretch_sound.playing:
			stretch_sound.play()


func compute_dragged_vector(gmp: Vector2) -> Vector2:
	return gmp - _drag_start

func drag_in_limits() -> void:
	_prev_dragged_vector = _dragged_vector
	_dragged_vector.x = clampf(_dragged_vector.x, DRAG_LIM_MIN.x, DRAG_LIM_MAX.x)
	_dragged_vector.y = clampf(_dragged_vector.y, DRAG_LIM_MIN.y, DRAG_LIM_MAX.y)
	
	position = _start_pos + _dragged_vector

func play_collision_sound() -> void:
	if _last_colision_count == 0 and get_contact_count() > 0 and !kick.playing:
		kick.play()
		_last_colision_count = 1


func update_flight() -> void:
	play_collision_sound()

func update_drag() -> void:
	if detect_release():
		return

	var gmp = get_global_mouse_position()
	_dragged_vector = compute_dragged_vector(gmp)
	play_stretch_sound()
	drag_in_limits()
	scale_arrow() 

func update(_delta: float) -> void:
	match _state:
		ANIMAL_STATE.DRAG:
			update_drag()
		ANIMAL_STATE.RELEASE:
			update_flight()

func die() -> void:
	queue_free()
	SignalManager.on_animal_died.emit()

func _on_visible_on_screen_enabler_2d_screen_exited():
	die()

func _on_input_event(_viewport, event, _shape_idx):
	if  _state == ANIMAL_STATE.READY and event.is_action_pressed("drag"):
		set_new_state(ANIMAL_STATE.DRAG)

func _on_sleeping_state_changed():
	if sleeping:
		var cb = get_colliding_bodies()
		if cb.size() > 0 and cb[0].has_method("die"):
			cb[0].die()
		call_deferred("die")
