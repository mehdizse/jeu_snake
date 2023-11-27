Class {
	#name : #SnakeTest,
	#superclass : #TestCase,
	#instVars : [
		'snake',
		'food'
	],
	#category : #snake
}

{ #category : #running }
SnakeTest >> setUp [
    "Set up a new snake and food for each test"
    snake := Snake new.
    food := Food new position: (100@200)
]

{ #category : #tests }
SnakeTest >> testCollisionWithSelf [
    "Test that a collision with the snake itself is detected correctly"
    snake position: (100@200).
    snake segments addFirst: (100@200).
    self assert: (snake checkCollisionWithSelf: snake position).
]

{ #category : #tests }
SnakeTest >> testCollisionWithWall [
    "Test that a collision with the wall is detected correctly"
    snake position: (800@600).  "Assuming the wall is at (800@600)"
    self assert: (snake checkCollisionWithBorder).
]

{ #category : #tests }
SnakeTest >> testEatFood [
    "Test that the snake eats food correctly"
    food := Food new position: (200@200).
    snake checkCollisionWithFood: food.
    self assert: snake hasEatenFood.
]

{ #category : #tests }
SnakeTest >> testMove [
    "Test that the snake moves correctly by 20 on the 4 position"
    snake move: 'right'.
    self assert: snake position x equals: 220.  
    self assert: snake position y equals: 200. 
    snake move: 'down'.
    self assert: snake position x equals: 220.  
    self assert: snake position y equals: 220.   
    snake move: 'left'.
    self assert: snake position x equals: 200.  
    self assert: snake position y equals: 220. 
    snake move: 'up'.
    self assert: snake position x equals: 200.  
    self assert: snake position y equals: 200.
   "down after up not possible so it on same value"
    snake move: 'down'.
    self assert: snake position x equals: 200.  
    self assert: snake position y equals: 200.  
]
