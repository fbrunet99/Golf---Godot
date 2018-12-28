extends Area2D

signal card_clicked(value)
signal card_removed(value)
export (int) var card_number = 0 setget set_card_number, get_card_number
export (String) var suit = "heart" setget get_suit
export (int) var value setget get_value


var cardNames = [ "back", 
"club_1", "club_2", "club_3", "club_4", "club_5", "club_6", "club_7", "club_8", "club_9", "club_10", "club_jack", "club_queen", "club_king",
"diamond_1", "diamond_2", "diamond_3", "diamond_4", "diamond_5", "diamond_6", "diamond_7", "diamond_8", "diamond_9", "diamond_10", "diamond_jack", "diamond_queen", "diamond_king",
"heart_1", "heart_2", "heart_3", "heart_4", "heart_5", "heart_6", "heart_7", "heart_8", "heart_9", "heart_10", "heart_jack", "heart_queen", "heart_king",
"spade_1", "spade_2", "spade_3", "spade_4", "spade_5", "spade_6", "spade_7", "spade_8", "spade_9", "spade_10", "spade_jack", "spade_queen", "spade_king"
	]
	
var deck = Array()
var cardInfo =  {
	idx = 0,
	name ="",
	value=0,
	ref=self
}

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	# init_cardImages()
	pass

func move(target):
	pass
	


func _process():
	print("process")
	pass

func _init():
	pass

func init_cardImages():
	var i
	var cardImage
	
	for i in range(0, cardNames.size()):
		cardImage = ImageTexture.new()
		cardImage.load("res://assets/1x/" + cardNames[i] + ".png")
		deck.append(cardImage)
	
	

func set_card_number(value):
	
	if deck.size() == 0 :
		init_cardImages()
		
	cardInfo.idx = value
	if cardInfo.idx > deck.size() :
		cardInfo.idx = cardInfo.idx % deck.size()
	cardInfo.name = cardNames[cardInfo.idx]	
	var parts = cardInfo.name.split("_")
	cardInfo.suit = parts[0]
	if parts.size() > 1:
		cardInfo.value = get_face_value(parts[1])
	
	var cardValue = cardInfo.value
		
	var sprite = $CardSprite
	var cardImage
	
	if sprite && deck.size() > cardInfo.idx :
		cardImage = deck[cardInfo.idx]
		sprite.set_texture(cardImage)
	
	
func get_card_number():
	return cardInfo.idx

func get_face_value(value):
	if (value == null) : 
		value = 0
	var ret = int(value)
	match(value):
		"king":
			ret = 13
		"queen":
			ret = 12
		"jack":
			ret = 11
		"ace":
			ret = 1
		"back":
			ret = -1
	
	return ret

func get_suit():
	return cardInfo.suit
	
func get_value():
	var cardValue = cardInfo.value
	return cardInfo.value

func _on_Card_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("clicked card" + self.cardInfo.name + " suit=" + cardInfo.suit + " value=" + str(cardInfo.value))
		emit_signal("card_clicked", cardInfo)
	return(self)
	
	


func _on_Tween_tween_completed(object, key):
	print("Removing self")
	get_parent().remove_child(self)
	emit_signal("card_removed", self)

