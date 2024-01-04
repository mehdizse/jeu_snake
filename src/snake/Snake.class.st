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

{ #category : #accessing }
Snake >> head [ 
 ^head.
]

{ #category : #initialization }
Snake >> initialize [
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
    | direction newPosition oppositeDirection |

    oppositeDirection := lastDirection caseOf: {
        ['up'] -> [ 'down' ].
        ['down'] -> [ 'up' ].
        ['left'] -> [ 'right' ].
        ['right'] -> [ 'left' ].
    } otherwise: [ '' ].

    directionString = oppositeDirection ifTrue: [ ^ head ].

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
        ifFalse: [ ^ newPosition ].

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
