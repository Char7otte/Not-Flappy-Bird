extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -1000.0 
const GRAVITY = 50.0

var screen_size

signal game_over

@onready var animations = $AnimatedSprite2D

@onready var pipe_hit_audio = $PipeHit
@onready var player_flap_audio = $PlayerFlap
@onready var score_get_audio = $ScoreGet

func _ready():
	screen_size = get_viewport_rect()

func _physics_process(_delta):
	move_and_slide()
	
	if Singleton.player_input_enabled:
		velocity.y += GRAVITY
		
		if Input.is_action_just_pressed("Jump") || Input.is_action_just_pressed("Left_click"):
			velocity.y = JUMP_VELOCITY
			player_flap_audio.play()
		
		animations.play("wings_down")
		if velocity.y < 0:
			animations.play("wings_up")
		
		if position.y > screen_size.end.y || position.y < 0:
			destroy_player()

func _on_area_2d_area_entered(area):
	if area.name == "Top Pipe" || area.name == "Bottom Pipe":
		destroy_player()
	
	if area.name == "Pipe Cleared":
		Singleton.score += 1
		score_get_audio.play()

func destroy_player():
	pipe_hit_audio.play()
	emit_signal("game_over")

