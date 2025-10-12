extends CharacterBody2D
@onready var player :=$"../CharacterBody2D"
var x = 0
var updownlaser = preload("res://up_or_down.tscn")
var asteroid = preload("res://asteroid.tscn")
var selfvelocity = 0
var selfvelocityx = 0
var cooldown = 0
var isattacking = false
var movecooldown = 3
var speed = 0



	
func laserspawnmode() ->void:
	
	for i in range(0,randi_range(3,6)):
		await get_tree().create_timer(1).timeout	
		var clone = updownlaser.instantiate()
		self.get_parent().add_child(clone)
		clone.position = Vector2(2773.0,-100.0) 
		var randomnumber = randi_range(0,1)
		var positionnumber = randi_range(0,1)
		if positionnumber == 0:
			clone.position.x =1673.0
			clone.set_meta("right",true)
		else:
			clone.position.x =2773.0
			
			
	
		if randomnumber == 1:
			clone.position.y -= 100
			
		

	isattacking = false

func asteroidfall() ->void:
	
	for i in range(0,randi_range(10,20)):
		await get_tree().create_timer(0.5).timeout
		var xrandompos = randi_range(1673.0,2704.0)
		var clone = asteroid.instantiate()
		self.get_parent().add_child(clone)
		clone.position = Vector2(xrandompos,-563.0)
		
	isattacking = false
	
	

	

func _physics_process(delta: float) -> void:
	movecooldown += delta
	
	
	if movecooldown >= 1:
		movecooldown = 0
		speed = randi_range(-60,60)
	
	if self.position.x <= 1661.0 and speed <= 0:
		speed = speed * -1
	if self.position.x >= 2736.0 and speed >= 0:
		speed = speed * -1
	
	self.velocity.x = speed
	
	move_and_slide()
	

		
	if isattacking:
		self.velocity.x = 0
	if isattacking == false:
		cooldown += delta
	if cooldown >= 2 and isattacking != true:
		isattacking = true	
		cooldown = 0
		var randomnumber = randi_range(0,1)
		if randomnumber ==0:
			asteroidfall()
		elif randomnumber == 1:
			laserspawnmode()
	
	


	
