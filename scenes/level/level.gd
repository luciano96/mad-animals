extends Node2D

const ANIMAL_SCENE = preload("res://scenes/animal/animal.tscn")

@onready var animal_start = $AnimalStart

func place_animal() -> void:
	var animal = ANIMAL_SCENE.instantiate()
	animal.position = animal_start.position
	add_child(animal)

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_animal_died.connect(on_animal_died)
	place_animal()

func on_animal_died():
	place_animal()
