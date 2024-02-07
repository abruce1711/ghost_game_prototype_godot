extends Area3D
class_name Door

func _on_area_entered(area):
	if area is HitboxComponent && area.get_parent() is Human:
		var human : Human = area.get_parent()
		human.queue_free()
