extends Node

export (PackedScene) var Card

var _deck = []
var _tableau = [ 100, 200, 300, 400, 500, 600, 700 ]
var _cur_card = 0

func _ready():
	randomize()
	setup_deck()
	draw_cards()
	
	print("b Foundation card number = " + str($Foundation.card_number) + 
			"  value=" + str($Foundation.cardInfo.value))
				
	$Foundation.card_number = _deck[_cur_card].cardInfo.idx
	var myCard = $Foundation
	print("a Foundation card number = " + str($Foundation.card_number) + 
			"  value=" + str($Foundation.cardInfo.value))

func setup_deck() :
	var i
	var cdx
	for i in range(1, 52) :
		cdx = i
		var newCard = Card.instance(cdx)
		newCard.card_number = cdx
		_deck.append(newCard)
	
	_deck = shuffleList(_deck)
	

func draw_cards() :
	var i
	var j = 0
	var y = 130
	var x
	
	for i in range(1, 36 ) :
		if j > 6 :
			y += 30
			j = 0

		x = _tableau[j]
		j += 1
		_cur_card += 1

		var nextCard = _deck[i]
		var loc = Vector2(x, y)
		nextCard.global_position = loc
		
		nextCard.connect("card_clicked", self, "_on_Playfield_card_clicked")
		add_child(nextCard)
		

	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_NextCard_pressed():
	pass

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

func _on_Stock_card_clicked(value):
	print("on_Stock_card_clicked value= " + str(value))
	_cur_card += 1
	if _cur_card > 51 :
		_cur_card = 51
	
	var nextCard = _deck[_cur_card]
	var cardNum = nextCard.card_number
	
	$Foundation.card_number = cardNum
	print("cur card = " + str(cardNum))
