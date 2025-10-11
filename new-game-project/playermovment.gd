extends CharacterBody2D
const speed = 300
var acceleartion= 1.5
var jumptimer = 0
var jumpallowed = true
var cooldown = false
var dash = false
var dashacc = 10
var dashtimer =0
var dashallowed = true
var dashright = true	
var isinbossarea= false


@onready var rigidbody = preload("res://rigid_body_2d.tscn")
@onready var Camera = $"../Camera2D"

func _physics_process(delta: float) -> void:
	
	self.velocity.y += 30
	self.velocity.x = 0
	
	
	if  dash == false:
		
		if Input.is_action_just_pressed("dash") and dash == false and dashallowed:
			dash = true
			
		if Input.is_action_pressed("left"):
			self.get_child(1).flip_h = true
			self.velocity.x = speed * -1
			dashright = false

		if Input.is_action_pressed("right"):
			self.get_child(1).flip_h = false
			self.velocity.x = speed
			dashright = true	
		if Input.is_action_just_pressed("shoot up"):
			if cooldown == false:
				cooldown = true	
				var clone = rigidbody.instantiate()
				
				clone.visible = true
				if self.get_child(1).flip_h :
					clone.position = Vector2(self.position.x -300,self.position.y -300)
				else:
					clone.position = Vector2(self.position.x +300,self.position.y -300)
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
	else:
		dashallowed = false
		self.velocity.y = 0
		if  dashright == true:
			self.velocity.x = 200 * dashacc
		else:
			self.velocity.x = -200 * dashacc
		dashacc -= 50*delta
		print("dashing")
		dashtimer += delta
		if dashtimer >= 0.2:
			dash = false
			dashacc = 10
			dashtimer =0
			await get_tree().create_timer(1).timeout
			dashallowed = true	
	if not is_on_floor() and jumptimer == 0:
		jumpallowed = false
	

		
	move_and_slide()
	if isinbossarea != true:
		Camera.position = self.position
	else:
		pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("laser"):

		get_tree().quit()
	elif area.is_in_group("asteroid"):
		area.get_parent().queue_free()


		


	


func _on_bossareaentered_area_entered(area: Area2D) -> void:

	Camera.position = Vector2(2199.0,-278.0)
	if area.is_in_group("player"):
		isinbossarea = true	
	else:
		print(area.get_groups())


	




func _on_bossareaentered_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
			isinbossarea = false
