extends Area2D

@onready var timer = $Timer
@onready var death_sfx: AudioStreamPlayer2D = $Death_sfx


func _on_body_entered(body):
	print("You Died!!")
	death_sfx.play()
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0 
	get_tree().reload_current_scene()
