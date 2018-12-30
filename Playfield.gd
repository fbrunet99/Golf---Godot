extends Node

export (PackedScene) var Card

var _deck = []
var _tableau = [ 100, 200, 300, 400, 500, 600, 700 ]
var _cur_card = 0
var _stock_remain
var _tableau_remain

func _ready():
	randomize()
	setup_deck()
	start_game()


func setup_deck() :
	var i
	var cdx
	
	for i in range(0, 52) :
		cdx = 1+i
		var newCard = Card.instance(cdx)
		newCard.card_number = cdx
		_deck.append(newCard)


# Start a new game
func start_game() :
	_cur_card = 1
	_stock_remain = 17
	_tableau_remain = 35
	
	_deck = shuffleList(_deck)
	draw_cards()
	$Foundation.card_number = _deck[_cur_card].cardInfo.idx
	$Stock.card_number = 0

func draw_cards() :
	var i
	var j = 0
	var y = 130
	var foundationSize = 35
	var x
	
	for i in range(0, foundationSize ) :
		if j > 6 :
			y += 30
			j = 0

		x = _tableau[j]
		j += 1

		var nextCard = _deck[i]
		var loc = Vector2(x, y)
		nextCard.global_position = loc
		nextCard.z_index = i
		
		nextCard.connect("card_clicked", self, "_on_Tableau_card_clicked")
		nextCard.connect("card_removed", self, "_on_Tableau_card_removed")
		add_child(nextCard)

	_cur_card = foundationSize
	print("cur_card=" + str(_cur_card))

	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_NewGame_pressed():
	start_game()
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
	var obj = cardInfo.ref
	var source = obj.global_position
	var target = $Foundation.global_position
	var tween = obj.get_child(2)
	
	tween.interpolate_property(obj, "position",
                source, target, 0.2,
                Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

#	remove_child(cardInfo.ref)

func _on_Tableau_card_clicked(cardInfo):
	var value = cardInfo.value

	var value2 = $Foundation.cardInfo.value
	if isMatch(value, value2):
		print(str(value) + " and " + str(value2) + " match")
		remove_card(cardInfo)
	else:
		print(str(value) + " and " + str(value2) + " don't match")
	
func _on_Tableau_card_removed(obj):
	var cardInfo = obj.cardInfo
	
	_tableau_remain -= 1
	$Foundation.card_number = cardInfo.idx
	
	remove_child(obj)
	print("on_Tableau_card_removed, stock remain = " + str(_stock_remain))

func _on_Foundation_card_clicked(value):
	print("on_Foundation_card_clicked value= " + str(value))

	pass 

func _on_Stock_card_clicked(value):
	_cur_card += 1
	_stock_remain -= 1
	var cardNum
	
	if _stock_remain > 0:
		var nextCard = _deck[_cur_card]
		cardNum = nextCard.card_number
		$Foundation.card_number = cardNum	
	else:
		cardNum = -1
		$Stock.card_number = -1
	

	print("on_Stock_card_clicked value= " + str(value) + " remain=" + str(_stock_remain))
