Class {
	#name : #Food,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #snake
}

{ #category : #initialization }
Food >> initialize [
    "Set the initial position of the food to a random point"
    position := ((2 to: 36) atRandom * 20) @ ((4 to: 26) atRandom * 20).
]

{ #category : #accessing }
Food >> position [
    ^ position.
]

{ #category : #accessing }
Food >> position: aPosition [
 position := aPosition.
]
