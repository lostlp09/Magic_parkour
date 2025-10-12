extends Node2D
@onready var preview = $CharacterBody2D/Node2D
@onready  var player = $CharacterBody2D
@onready var bullet = $Bullet
var  Bullets = []
var shootcooldown  = false
@onready var Boss = $Bossfight
@onready var area2d = $Bullet/Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and preview.visible and shootcooldown == false :
		shootcooldown = true
		var direction = preview.rotation
		var clone:Sprite2D = bullet.duplicate()
	
		print(preview.position)
		self.add_child(clone)
		
		clone.visible = true
		clone.position = player.position + Vector2(0,-33)
		clone.rotation = direction
		Bullets.append({"Bullet":clone,"Time":0,"direction":direction})
		await  get_tree().create_timer(0.5).timeout.connect(func timer():shootcooldown = false)

	for i in Bullets:
		var dir = Vector2.RIGHT.rotated(i["direction"])
		i["Time"] += delta
		if i["Bullet"] != null:
			i["Bullet"].position  += dir *3

		if i["Time"] >=2:
			if i["Bullet"] != null:
				i["Bullet"].queue_free()
				Bullets.erase(i)


func shootfunc(area: Area2D,Bullet:Node) -> void:
	if area.is_in_group("boss"):
		Bullet.queue_free()
		Bullets.erase(Bullet)
		Boss.set_meta("bosshp",Boss.get_meta("bosshp") - 10)
		
		
	else:
		print("error")
	


func _on_bossarea_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		Bullets.erase(area.get_parent())
		Boss.set_meta("bosshp",Boss.get_meta("bosshp") - 10)
		area.get_parent().queue_free()
		
		
	else:
		print("error")
	
	pass # Replace with function body.
