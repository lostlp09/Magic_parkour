extends Sprite2D
var timer = 0



		
func _process(delta: float) -> void:
	timer += delta
	
	self.position.x -= 3
	if timer >= 3:
		self.queue_free()
		print("dead")
	
