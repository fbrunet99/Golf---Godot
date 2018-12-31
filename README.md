# Golf---Godot
Golf Card Game in Godot

This is a simple "Golf" Card Game written in Godot engine.

The card faces are from SVG Cards (https://www.npmjs.com/package/svg-cards), originally created by David Bellot.

## How to Play
Click a card that is one higher or lower than the face-up foundation card. Win by playing all the Tablea Cards.

 * Ace matches King or 2

## Parts of the Screen
### New
Starts a new game

### Tableau
Try to remove all of these cards by matching one higher or lower than the foundation card

### Stock
Click this to get a new foundation card

### Foundation
This is the card that you are trying to match one higher or lower.


## To Do

### Essential
* Detect empty tableau (win)
* Game over page (CanvasLayer)
* Add custom font and use it to change the score size
* Fix bug where remaining count isn't right or doesn't show last card
* Set background color to dark green (add ColorRect to playfield)

### Nice to have
* Undo
* Animate cards from stock to tableau on start
* Animate card from stock to Foundation on click of stock
* Add card flip sound