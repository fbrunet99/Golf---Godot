extends Node

export (PackedScene) var Card

var deck = []
var curCard = 0


func _ready():
	randomize()
	setup_deck()
	draw_cards()
	$Foundation.card_number = curCard
	

func setup_deck() :
	var i
	var cdx
	for i in range(1, 52) :
		cdx = i
		var newCard = Card.instance()
		newCard.card_number = cdx
		deck.append(newCard)
		
	deck = shuffleList(deck)
	

func draw_cards() :
	var i
	
	for i in range (1, 10) :
		var x = i * 100
		var y = 200
		var curCard = deck[i]
		var loc = Vector2(x, y)
		curCard.global_position = loc
		add_child(curCard)
	


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

# Shuffle array
func shuffleList(list):
	var shuffledList = []
	var indexList = range(list.size())
	for i in range(list.size()):
		var x = randi()%indexList.size()
		shuffledList.append(list[x])
		indexList.remove(x)
		list.remove(x)
	return shuffledList

