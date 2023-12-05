Class {
	#name : #Snake,
	#superclass : #Object,
	#instVars : [
		'head',
		'segments',
		'lastDirection',
		'hasEatenFood',
		'score'
	],
	#category : #snake
}

{ #category : #'as yet unclassified' }
Snake >> checkCollisionWithBorder [
    |collid|
    "comparer si la tete du serpent a heurter un des murs "
   "x<=20 mure gauche    y<=60 mure haut   x>=760 mure droit  y>=560 mure bas"
   "si l'une des conditions est vrai on renvoie true c'est a dire collision" 
    collid:= head x <= 20 or: [head y <= 60 or: [head x >= 760 or: [head y >= 560]]].
   ^collid.
]

{ #category : #'as yet unclassified' }
Snake >> checkCollisionWithFood: aFood [
    | collided |
    collided := head = aFood position.
    collided ifTrue: [ 
	     score := score + 1. 
	     hasEatenFood := true.
	   ].
    ^ collided
]

{ #category : #'as yet unclassified' }
Snake >> checkCollisionWithSelf: newPosition [
    | bodySegments collision |
    "comparerer la nouvelle position de la tete avec tous les autre segments "
    bodySegments := segments allButLast.
    collision := bodySegments includes: newPosition.
    ^ collision
]

{ #category : #accessing }
Snake >> hasEatenFood [ 
 ^hasEatenFood.
]

{ #category : #accessing }
Snake >> hasEatenFood: aBoolean [
    hasEatenFood := aBoolean.
]

{ #category : #initialization }
Snake >> initialize [
    "Set the initial position before moving the snake"
    head := 100@200.
    segments := OrderedCollection new.
    "Initialize the segments with a few positions to the left of the head"
    1 to: 5 do: [ :i | segments add: ((100 - i * 20) @ 200) ].
    lastDirection := 'right'.
    hasEatenFood := false.
    score:=0.
    1 to: 5 do: [ :_ | self move: lastDirection ].
]

{ #category : #accessing }
Snake >> lastDirection [
  ^lastDirection.
]

{ #category : #accessing }
Snake >> lastDirection: aLastDirection [
 lastDirection := aLastDirection.
]

{ #category : #accessing }
Snake >> move: directionString [
    | direction newPosition|

    direction := directionString caseOf: {
        ['up'] -> [ 0 @ -20 ].
        ['down'] -> [ 0 @ 20 ].
        ['left'] -> [ -20 @ 0 ].
        ['right'] -> [ 20 @ 0 ].
    } otherwise: [ 0 @ 0 ].

    newPosition := head + direction.

    "Check if the new position is within the bounds"
    ((newPosition x between: 20 and: 760) and: [ newPosition y between: 60 and: 560 ])
        ifTrue: [
            head := newPosition.
            segments add: head.
            hasEatenFood ifFalse: [ segments removeFirst ].
            lastDirection := directionString. "Update lastDirection only when the move is performed"
        ]
        ifFalse: [ ^ newPosition ].  "Do nothing if the new position is out of bounds"

    ^ newPosition.
]

{ #category : #accessing }
Snake >> position [
    ^ head.
]

{ #category : #accessing }
Snake >> position: aPosition [
 head:= aPosition.
]

{ #category : #accessing }
Snake >> score [
 ^score.
]

{ #category : #accessing }
Snake >> segments [
    ^ segments.
]
