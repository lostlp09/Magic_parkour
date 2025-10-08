extends  RigidBody2D


func _on_body_entered(body: Node) -> void:
	self.queue_free()
