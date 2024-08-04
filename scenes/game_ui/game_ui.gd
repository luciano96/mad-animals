extends Control

const MAIN = preload("res://scenes/mainui/main.tscn")
@onready var go_sound = $GOSound
@onready var attempts_label = $MarginContainer/VB/Attempts
@onready var level_label = $MarginContainer/VB/LevelLabel
@onready var v_box_container_2 = $MarginContainer/VBoxContainer2

# Called when the node enters the scene tree for the first time.
func _ready():
	level_label.text = "Level %s" % ScoreManager.get_level_selected()
	update_attempts(0)
	SignalManager.on_update_attempts.connect(update_attempts)
	SignalManager.on_level_complete.connect(on_level_complete)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if v_box_container_2.visible and Input.is_action_just_pressed("Menu"):
		get_tree().change_scene_to_packed(MAIN)


func update_attempts(attempts: int) -> void:
	attempts_label.text = "Attempts %s" % attempts

func on_level_complete() -> void:
	v_box_container_2.show()
	go_sound.play()
