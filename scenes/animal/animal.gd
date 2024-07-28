extends RigidBody2D

enum ANIMAL_STATE { READY, DRAG, RELEASE }

const DRAG_LIM_MAX: Vector2 = Vector2(0, 60)
const DRAG_LIM_MIN: Vector2 = Vector2(-60, 0)

var _state: ANIMAL_STATE = ANIMAL_STATE.READY
var _start_pos: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _prev_dragged_vector: Vector2 = Vector2.ZERO

@onready var stretch_sound = $Stretch
@onready var arrow = $Arrow


func _ready():
	arrow.hide()
	_start_pos = position

func _physics_process(delta):
	update(delta)

func set_new_state(new_state: ANIMAL_STATE) -> void:
	_state = new_state
	match _state:
		ANIMAL_STATE.RELEASE:
			freeze = false
			arrow.hide()
		ANIMAL_STATE.DRAG:
			_drag_start = get_global_mouse_position()
			arrow.show()

func detect_release() -> bool:
	if _state == ANIMAL_STATE.DRAG:
		if Input.is_action_just_released("drag"):
			set_new_state(ANIMAL_STATE.RELEASE)
			return true
	return false

func scale_arrow() -> void:
	print(position)
	print(_start_pos)
	print( (position - _start_pos).angle())
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
	
	
func update_drag() -> void:
	if detect_release():
		return

	var gmp = get_global_mouse_position()
	_dragged_vector = compute_dragged_vector(gmp)
	play_stretch_sound()
	drag_in_limits()
	scale_arrow() 

func update(delta: float) -> void:
	match _state:
		ANIMAL_STATE.DRAG:
			update_drag()

func die() -> void:
	queue_free()
	SignalManager.on_animal_died.emit()

func _on_visible_on_screen_enabler_2d_screen_exited():
	die()

func _on_input_event(viewport, event, shape_idx):
	if  _state == ANIMAL_STATE.READY and event.is_action_pressed("drag"):
		set_new_state(ANIMAL_STATE.DRAG)
