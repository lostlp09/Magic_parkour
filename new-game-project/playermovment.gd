extends CharacterBody2D
const speed = 300
var acceleartion= 1
var jumptimer = 0
var jumpallowed = true
@onready var Camera = $"../Camera2D"
func _physics_process(delta: float) -> void:
	self.velocity.y += 30
	self.velocity.x = 0
	
	

	if Input.is_action_pressed("left"):
		self.velocity.x = speed * -1
	
	if Input.is_action_pressed("right"):
		self.velocity.x = speed		
	move_and_slide()
	Camera.position = self.position
	
	if Input.is_action_pressed("jump"):
		
	 
		
		if jumptimer < 1 and jumpallowed:

			jumptimer += 0.1
			acceleartion += 0.1
			self.velocity.y = speed * -1 * acceleartion
		
	elif not is_on_floor():
		jumptimer = 1		
	if is_on_floor():
		jumpallowed = true
		acceleartion =1
		jumptimer = 0
	if not is_on_floor() and jumptimer == 0:
		jumpallowed = false
		
		
	
	
	
