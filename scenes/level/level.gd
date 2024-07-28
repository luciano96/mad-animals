extends Node2D

@onready var animal_start = $AnimalStart
const ANIMAL_SCENE = preload("res://scenes/animal/animal.tscn")

func place_animal() -> void:
	var animal = ANIMAL_SCENE.instantiate()
	animal.position = animal_start.position
	add_child(animal)

# Called when the node enters the scene tree for the first time.
func _ready():
	place_animal()
	SignalManager.on_animal_died.connect(on_animal_died)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_animal_died():
	place_animal()
