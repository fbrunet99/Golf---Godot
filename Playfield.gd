extends Node

var curCard = 0
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$Foundation.card_number = curCard
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_NextCard_pressed():
	curCard += 1
	if curCard > 52 :
		curCard = 0
	$Foundation.card_number = curCard
	print("cur card = " + str(curCard))
	
