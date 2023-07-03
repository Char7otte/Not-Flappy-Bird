extends Node2D

@export var travelSpeed = 300.0

func _ready():
	randomizeHeight()

func _process(delta):
	position.x -= travelSpeed * delta
	
	if position.x < -752.0:
		position.x = 3248.0
		randomizeHeight()

func randomizeHeight():
	position.y = randf_range(272.0, 816.0)

