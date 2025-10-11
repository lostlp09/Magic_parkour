extends CharacterBody2D
@onready var player :=$"../CharacterBody2D"
var x = 0
var updownlaser = preload("res://up_or_down.tscn")
var asteroid = preload("res://asteroid.tscn")
var selfvelocity = 0

@onready var malen = $"../Sprite2D2"
func jump_on_player() ->void:
	var playerpostion = player.position.x

	var boss = self.position.x
	var midnumber = (boss + playerpostion)/2
	var multi = -300 /(self.position.x + midnumber) *(self.position.x + midnumber)
	print(midnumber)
	
	while self.position.y <= -1:
		var clone = malen.duplicate()
		self.get_parent().add_child(clone)
		clone.position = self.position
	
	
		if playerpostion>=boss:
			self.position.x += 10
			self.position.y = 0.001*(self.position.x-playerpostion)*(self.position.x-boss)
			await get_tree().create_timer(0.01).timeout
		
		else:
			self.position.x -= 10
			self.position.y = 0.001*(self.position.x-playerpostion)*(self.position.x-boss)
			await get_tree().create_timer(0.01).timeout
	
func laserspawnmode() ->void:
	for i in range(0,100):
		print("fly")
		selfvelocity = -550
		await  get_tree().create_timer(0.001).timeout
	selfvelocity = 0

	for i in range(0,randi_range(3,6)):
		var clone = updownlaser.instantiate()
		self.get_parent().add_child(clone)
		clone.position = Vector2(2773.0,-100.0) 
		var randomnumber = randi_range(0,1)
		if randomnumber == 1:
			clone.position.y -= 100
			
		await get_tree().create_timer(1).timeout	
	for i in range(0,100):
		print("flydown")
		selfvelocity =550
		await  get_tree().create_timer(0.001).timeout

func asteroidfall() ->void:
	for i in range(0,randi_range(10,20)):
		print("hi")
		var xrandompos = randi_range(1673.0,2704.0)
		var clone = asteroid.instantiate()
		self.get_parent().add_child(clone)
		clone.position = Vector2(xrandompos,-563.0)
		await get_tree().create_timer(0.5).timeout
	
	

func _ready() -> void:
	asteroidfall()

func _physics_process(delta: float) -> void:
	self.velocity.y = selfvelocity
	move_and_slide()
	

	
	
	
	
	
	
	
	
	
	
	
