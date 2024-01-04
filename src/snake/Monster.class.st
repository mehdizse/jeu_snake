Class {
	#name : #Monster,
	#superclass : #BlElement,
	#instVars : [
		'position'
	],
	#category : #snake
}

{ #category : #initialization }
Monster >> initialize [
    super initialize.
    self size: (20@20) .  
    self background: Color orange.
    self border: (BlBorder paint: Color black width: 1).
    self geometry: (BlRectangle cornerRadius: 10).
]

{ #category : #'as yet unclassified' }
Monster >> moveRandomly [
    position := ((2 to: 36) atRandom * 20) @ ((4 to: 26) atRandom * 20).
    self position: position
]
