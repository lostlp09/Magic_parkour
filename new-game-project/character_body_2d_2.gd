extends CharacterBody2D
@onready var player :=$"../CharacterBody2D"
var x = 0

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
			
		
		
	

	
		
		

func _ready() -> void:
	jump_on_player()

	
	
	
	
	
	
	
	
	
	
	
