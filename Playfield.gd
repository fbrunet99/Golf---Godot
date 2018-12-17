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
		
		curCard.connect("card_clicked", self, "_on_Playfield_card_clicked")
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


func isMatch(value1, value2):
	if ((value1 == 1 && value2 == 13) || (value1 == 13 && value2 == 1)):
		return true
	
	var diff = value1 - value2
	var ret = false
	match diff:
		-1:
			ret = true
		1: 
			ret = true
	return ret
	
func remove_card(cardInfo):
	$Foundation.card_number = cardInfo.idx
	remove_child(cardInfo.ref)

func _on_Playfield_card_clicked(cardInfo):
	var value = cardInfo.value
	print("on_playfield_card_clicked" + str(value))
	var value2 = $Foundation.cardInfo.value
	if isMatch(value, value2):
		print(str(value) + " and " + str(value2) + " match")
		remove_card(cardInfo)
	else:
		print(str(value) + " and " + str(value2) + " don't match")
	

func _on_Foundation_card_clicked(value):
	print("on_Foundation_card_clicked value= " + str(value))
	pass # replace with function body
