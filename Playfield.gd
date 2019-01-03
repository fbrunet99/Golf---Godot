extends Node

export (PackedScene) var Card

var _deck = []
var _tableau = [ 150, 250, 350, 450, 550, 650, 750 ]
var _cur_card = 0
var _stock_remain
var _tableau_remain
var _vert_offset = 45
var _score = 0

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
	cleanup_display()
	_cur_card = 0
	_stock_remain = 17
	_tableau_remain = 35
	
	_deck = shuffleList(_deck)
	draw_cards()

	$Foundation.card_number = -1 #_deck[_cur_card].cardInfo.idx
	$Stock.card_number = 0
	_score -= 52
	update_score()

# Clean up the playfield for a new game
func cleanup_display():
	var i
	for i in range(0, _deck.size()):
		var curCard = _deck[i]
		remove_child(curCard)

# Draw the score on the screen
func update_score():
	$StockRemaining.text = str(_stock_remain)
	$Score.text = str(_score)

# Deal the cards onto the playfield
func draw_cards() :
	var i
	var j = 0
	var y = 130
	var foundationSize = 35
	var x
	var nextCard
	var loc
	
	for i in range(0, foundationSize ) :
		if j > 6 :
			y += _vert_offset
			j = 0

		x = _tableau[j]
		j += 1

		nextCard = _deck[i]
		loc = Vector2(x, y)
		nextCard.global_position = loc
		nextCard.z_index = i
		
		nextCard.connect("card_clicked", self, "_on_Tableau_card_clicked")
		nextCard.connect("card_removed", self, "_on_Tableau_card_removed")
		add_child(nextCard)

	_cur_card = foundationSize -1
	
	loc = $Stock.global_position
	loc = Vector2(loc.x - 1, loc.y)
	for i in range(foundationSize, _deck.size()):
		nextCard = _deck[i]
		nextCard.global_position = loc
		nextCard.cardInfo.pileType = "stock"
		nextCard.z_index = _deck.size() - i
		nextCard.connect("card_removed", self, "_on_Stock_card_removed")
		add_child(nextCard)
		#loc = Vector2(loc.x -1, loc.y)
	
	print("cur_card=" + str(_cur_card))

	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

# Start a new game
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

# Check if the two values match for Golf Solitaire rules (1 higher or lower)
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
	
# Remove a card from the tableau
func remove_card(cardInfo):
	var obj = cardInfo.ref
	var target = $Foundation.global_position
	tween_card(obj, target)

#	remove_child(cardInfo.ref)

# Animate the given card to the target position
func tween_card(card, targetPos):
	var source = card.global_position
	card.z_index = 999
	var tween = card.get_child(2)
	tween.interpolate_property(card, "position",
                source, targetPos, 0.2,
                Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	
# Process a tableau card 
func _on_Tableau_card_clicked(cardInfo):
	var value = cardInfo.value

	var value2 = $Foundation.cardInfo.value
	if isMatch(value, value2):
		print(str(value) + " and " + str(value2) + " match")
		remove_card(cardInfo)
	else:
		print(str(value) + " and " + str(value2) + " don't match")
	
# Process the card after it has been animated
func _on_Tableau_card_removed(obj):
	var cardInfo = obj.cardInfo
	
	_tableau_remain -= 1
	$Foundation.card_number = cardInfo.idx
	
	remove_child(obj)
	print("on_Tableau_card_removed, tableau remain = " + str(_tableau_remain))
	_score += 5
	update_score()

func _on_Foundation_card_clicked(value):
	print("on_Foundation_card_clicked value= " + str(value))

	pass 

func _on_Stock_card_clicked(value):
	var cardNum	
	_stock_remain -= 1
	
	if _stock_remain >= 0:
		_cur_card += 1
		var nextCard = _deck[_cur_card]
		cardNum = nextCard.card_number
		tween_card(nextCard, $Foundation.global_position)
	
	if _stock_remain <= 0:
		_stock_remain = 0
		cardNum = -1
		$Stock.card_number = -1
	
	update_score()
	print("on_Stock_card_clicked value= " + str(value) + " remain=" + str(_stock_remain))

func _on_Stock_card_removed(obj):
	var cardInfo = obj.cardInfo
	print("on_Stock_card_removed " + str(cardInfo.value))	
	$Foundation.card_number = obj.card_number	
	obj.z_index = 0
