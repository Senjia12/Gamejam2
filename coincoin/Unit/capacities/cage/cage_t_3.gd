extends StaticBody2D


var hp := 250
var next_couik := false

func _ready() -> void:
	$Sprite2D.play("default")
	$Sprite2D2.play("default")


func take_damage(dmg):
	hp -= dmg
	if hp <= 0:
		$Sprite2D.play_backwards("default")
		$Sprite2D2.play_backwards("default")
		next_couik = true


func _on_dispawn_timeout() -> void:
	queue_free()


func _on_sprite_2d_animation_finished() -> void:
	if next_couik:
		queue_free()
