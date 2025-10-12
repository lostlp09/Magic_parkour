extends  ProgressBar
@onready var boss = $"../Bossfight"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.value = boss.get_meta("bosshp")
	
	if self.value <= 0 :
		get_tree().change_scene_to_file("res://youwin.tscn")
