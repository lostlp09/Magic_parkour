extends CharacterBody2D
var maxleft
var maxright
var accelartion = 1
const speed = 300.0
var left = false
func _ready() -> void:
	maxleft = self.position.x -200
	maxright = self.position.x +200



func _physics_process(delta: float) -> void:
	if maxright != null:
	
		if left == true:
			accelartion += 1.5 * delta
			self.velocity.x = speed * -1 * accelartion
			if self.position.x <= maxleft:
				accelartion = 1
				left = false			
		else:
			accelartion += 1.5 * delta
			self.velocity.x = speed  *accelartion
			if self.position.x >= maxright:
				accelartion = 1
				left = true
	move_and_slide()
