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
var bounced = 0
var bouncooldown = 0
@onready var area = $Area2D
@onready var bulletpreview= $Node2D
@onready var Raycastobject = $RayCast2D

		

@onready var rigidbody = preload("res://rigid_body_2d.tscn")
@onready var Camera = $"../Camera2D"

func _physics_process(delta: float) -> void:


	
		

	if Input.is_action_pressed("mouseforshoot"):
		bulletpreview.visible = true
	else:
		bulletpreview.visible = false
	var mouse_pos =  get_global_mouse_position()
	bulletpreview.look_at(mouse_pos)
	self.velocity.y += 30
	self.velocity.x = 0
	if bounced <= 0:
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
		dash = false
		dashallowed = true
		dashacc = 10
		bouncooldown += delta
		if bounced == 1:
			self.velocity.x += 300
			
		
		
		elif bounced == 2:
					self.velocity.x -= 300
			
		elif bounced == 3:
			self.velocity.x += 1000
			self.velocity.y += 100
		else:
			self.velocity.x += 150
			self.velocity.y = -200
		move_and_slide()
		if bouncooldown >= 0.5:
			bounced = 0
			bouncooldown = 0

func _on_area_2d_area_entered(area: Area2D) -> void:


	if area.is_in_group("laser"):
		get_tree().change_scene_to_file("res://you lose.tscn")
	elif area.is_in_group("asteroid"):
		area.get_parent().queue_free()	
		get_tree().change_scene_to_file("res://you lose.tscn")
func _on_bossareaentered_area_entered(area: Area2D) -> void:
	Camera.position = Vector2(2199.0,-278.0)
	if area.is_in_group("player"):
		isinbossarea = true	
func _on_bossareaentered_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
			isinbossarea = false
func _on_areafor_bouncing_area_entered(area: Area2D) -> void:
		if  area.is_in_group("boss"):
			if Raycastobject.is_colliding():
				print("he is left")
				bounced = 1
			else:
				Raycastobject.rotation_degrees = -90
				Raycastobject.force_raycast_update()
				if Raycastobject.is_colliding():
					print("he is right")
					bounced = 2
					
				else:
					 
					Raycastobject.rotation_degrees = -180

					if  Raycastobject.is_colliding():
						
						print("he is top")
						bounced = 3
					
					else:
						Raycastobject.rotation_degrees = 360
						Raycastobject.force_raycast_update()
						if Raycastobject.is_colliding():
							print("he is under")
							bounced = 4
						else:
							print("nope")
			Raycastobject.rotation_degrees = 90
			Raycastobject.force_raycast_update()
		
