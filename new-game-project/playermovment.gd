extends CharacterBody2D
const speed = 300
var acceleartion= 1.5
var jumptimer = 0
var jumpallowed = true
var cooldown = false
@onready var rigidbody = preload("res://rigid_body_2d.tscn")
@onready var Camera = $"../Camera2D"

func _physics_process(delta: float) -> void:
	self.velocity.y += 30
	self.velocity.x = 0
	
	

	if Input.is_action_pressed("left"):
		
		self.velocity.x = speed * -1
	
	if Input.is_action_pressed("right"):
		self.velocity.x = speed		
	



	if Input.is_action_just_pressed("shoot up"):
		if cooldown == false:
			cooldown = true	
			var clone = rigidbody.instantiate()
			
			clone.visible = true
			clone.position = Vector2(self.position.x + 300,self.position.y -300)
			
			self.get_parent().add_child(clone)
			await get_tree().create_timer(1).timeout.connect(func test() -> void: cooldown = false )

		
		
		
	
	if Input.is_action_pressed("jump"):
	
	
	
		if jumptimer < 0.3 and jumpallowed:

			jumptimer += delta
			acceleartion += 1.5* delta
			self.velocity.y = speed * -1 * acceleartion
	elif not is_on_floor():
		jumptimer = 1
		
	if is_on_floor():
		jumpallowed = true
		acceleartion =1.5
		jumptimer = 0
	if not is_on_floor() and jumptimer == 0:
		jumpallowed = false
	
	
	move_and_slide()
	Camera.position = self.position
		
		
	
	
	
