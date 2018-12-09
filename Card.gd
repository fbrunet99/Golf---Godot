extends Area2D

var cardNames = [ "back", 
"club_1", "club_2", "club_3", "club_4", "club_5", "club_6", "club_7", "club_8", "club_9", "club_10", "club_jack", "club_queen", "club_king",
"diamond_1", "diamond_2", "diamond_3", "diamond_4", "diamond_5", "diamond_6", "diamond_7", "diamond_8", "diamond_9", "diamond_10", "diamond_jack", "diamond_queen", "diamond_king",
"heart_1", "heart_2", "heart_3", "heart_4", "heart_5", "heart_6", "heart_7", "heart_8", "heart_9", "heart_10", "heart_jack", "heart_queen", "heart_king",
"spade_1", "spade_2", "spade_3", "spade_4", "spade_5", "spade_6", "spade_7", "spade_8", "spade_9", "spade_10", "spade_jack", "spade_queen", "spade_king"
	]
	
var deck = Array()
	
export (int) var card_number = 0 setget set_card_number, get_card_number

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	# init_cardImages()
	pass

func init_cardImages():
	var i
	var cardImage
	
	for i in range(0, cardNames.size()):
		cardImage = ImageTexture.new()
		print(cardNames[i])
		cardImage.load("res://assets/1x/" + cardNames[i] + ".png")
		deck.append(cardImage)
	
	
	print (cardNames.size())
	print (deck.size())
		

func set_card_number(value):
	
	if deck.size() == 0 :
		init_cardImages()
		
	var cardNum = value
	if cardNum > deck.size() :
		cardNum = cardNum % deck.size()
		
	var sprite = $CardSprite
	var cardImage
	
	if sprite && deck.size() > cardNum :
		cardImage = deck[cardNum]
		sprite.set_texture(cardImage)
	
	
func get_card_number():
	return card_number
