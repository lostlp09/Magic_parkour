extends Sprite2D
var timer = 0



		
func _process(delta: float) -> void:
	timer += delta
	if self.get_meta("right") == true:
		self.position.x += 3
	else:
		self.position.x -= 3
	if timer >= 3:
		self.queue_free()
		print("dead")
	
