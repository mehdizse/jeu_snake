Class {
	#name : #SnakeController,
	#superclass : #Object,
	#instVars : [
		'game',
		'model',
		'food',
		'foodElements',
		'space'
	],
	#category : #snake
}

{ #category : #'as yet unclassified' }
SnakeController >> createCloseButton [
    | closeButton |
    closeButton := BlElement new.
    closeButton
        position: (760@10);
        size: (30@30);
        background: Color red;
        when: BlClickEvent do: [ space close ].
    closeButton addChild: (BlTextElement new
        text: ('X' asRopedText fontSize: 35);
        position: (7@5)).
    space root addChild: closeButton.
]

{ #category : #'as yet unclassified' }
SnakeController >> createScoreElement [
    | scoreElement |
    scoreElement := BlTextElement new.
    scoreElement
        position: (10@10);
        size: (100@20);
        text: (('Score: ' , model score asString) asRopedText fontSize: 20).
    ^ scoreElement
]

{ #category : #'as yet unclassified' }
SnakeController >> createWalls [
    | wallTop wallBottom wallLeft wallRight |
    wallTop := BlElement new position: (0@40); size: (800@30); background: Color brown.
    wallBottom := BlElement new position: (0@570); size: (800@30); background: Color brown.
    wallLeft := BlElement new position: (0@40); size: (30@560); background: Color brown.
    wallRight := BlElement new position: (770@40); size: (30@560); background: Color brown.
    space root addChild: wallLeft.
    space root addChild: wallRight.
    space root addChild: wallBottom.
    space root addChild: wallTop.
]

{ #category : #'as yet unclassified' }
SnakeController >> gameOver [
    game childrenDo: [ :child | 
        (foodElements includes: child) ifFalse: [ 
            game removeChild: child.
        ]
    ].
      "Remove all children from space root"
    space root childrenDo: [ :child | space root removeChild: child ].


   
    model initialize.
    foodElements do: [ :foodElement | game removeChild: foodElement ].
    foodElements removeAll.
    foodElements add: (game updateFoodPosition: food position).
    
    game updateHeadPosition: model position segments: model segments.
    "Reset the game state"
    space close.
    self gameOverScreen.
]

{ #category : #'as yet unclassified' }
SnakeController >> gameOverScreen [
    | gameOverSpace gameOverTitle recommencerButton fermerButton |

    gameOverSpace := BlSpace new extent: (800@600); title:'Game Over'.

    gameOverTitle := BlTextElement new text: ('Game over' asRopedText fontSize: 60);position: (30@30).
    gameOverSpace root addChild: gameOverTitle.
    gameOverTitle layout.
    gameOverTitle position: (250 @ 40).

    recommencerButton := BlElement new.
    recommencerButton
        size: (300@50);
        background: Color green;
        border: (BlBorder paint: Color black width: 2);
        when: BlClickEvent do: [  
            gameOverSpace close.
            self openGame.
        ].

    recommencerButton addChild: (BlTextElement new
        text: ('Recommencer la partie' asRopedText fontSize: 30);
        position: (40@10)).
    gameOverSpace root addChild: recommencerButton.
    recommencerButton position: (230 @ 275).

    fermerButton := BlElement new.
    fermerButton
        size: (300@50);
        background: Color red;
        border: (BlBorder paint: Color black width: 2);
        when: BlClickEvent do: [ gameOverSpace close ].

    fermerButton addChild: (BlTextElement new
        text: ('Fermer le jeu' asRopedText fontSize: 30);
        position: (110@10)).
    gameOverSpace root addChild: fermerButton.
    fermerButton position: (230 @ 375).

    gameOverSpace show.


]

{ #category : #'as yet unclassified' }
SnakeController >> getDirectionStringFromKeyCode: keyCode [
    ^ keyCode caseOf: {
        [65362] -> [ 'up' ].    "Up arrow"
        [65364] -> [ 'down' ].  "Down arrow"
        [65361] -> [ 'left' ].  "Left arrow"
        [65363] -> [ 'right' ]. "Right arrow"
    } otherwise: [ model lastDirection ].  "Do nothing for other keys"
]

{ #category : #'as yet unclassified' }
SnakeController >> handleCollisionWithBorder: scoreElement [
    (model checkCollisionWithBorder) ifTrue: [
        self gameOver.
        scoreElement text: (('Score: ', model score asString) asRopedText fontSize: 20).
    ].
]

{ #category : #'as yet unclassified' }
SnakeController >> handleCollisionWithFood: scoreElement [
    (model checkCollisionWithFood: food) ifTrue: [
        food initialize.
        foodElements do: [ :foodElement | game removeChild: foodElement ].
        foodElements removeAll.
        foodElements add: (game updateFoodPosition: food position).
        scoreElement text: (('Score: ', model score asString) asRopedText fontSize: 20).
    ].
]

{ #category : #'as yet unclassified' }
SnakeController >> handleCollisionWithSelf: newPosition scoreElement: scoreElement [
    (model checkCollisionWithSelf: newPosition) ifTrue: [
        self gameOver.
        scoreElement text: (('Score: ', model score asString) asRopedText fontSize: 20).
    ].
]

{ #category : #'as yet unclassified' }
SnakeController >> handleKeyboardWithScoreElement: scoreElement [
    game space root when: BlKeyDownEvent do: [ :event |
        | keyCode directionString newPosition |
        keyCode := event key value.
        directionString := self getDirectionStringFromKeyCode: keyCode.

        newPosition := model move: directionString.

        self removeNonFoodElementsFromGame.

        game updateHeadPosition: model position segments: model segments.
        model hasEatenFood: false.

        self handleCollisionWithFood: scoreElement.
        self handleCollisionWithBorder: scoreElement.
        self handleCollisionWithSelf: newPosition scoreElement: scoreElement.
    ].
]

{ #category : #initialization }
SnakeController >> initialize [
    game := SnakeGame new.
    model := Snake new.
	 food := Food new.
	 foodElements := OrderedCollection new.
]

{ #category : #initialization }
SnakeController >> initializeFoodElements [
    foodElements ifNil: [ foodElements := OrderedCollection new ].
    foodElements add: (game updateFoodPosition: food position).
]

{ #category : #initialization }
SnakeController >> initializeSpace [
    space := BlSpace new extent: (800@600); title:'Jeu Snake'.
    space root addChild: game.
]

{ #category : #'as yet unclassified' }
SnakeController >> openGame [
    | scoreElement |

    self initializeSpace.
    scoreElement := self createScoreElement.
    

    space root addChild: scoreElement.

    self createWalls.
    self createCloseButton.

    game updateHeadPosition: model position segments: model segments.
    self initializeFoodElements.

    self handleKeyboardWithScoreElement: scoreElement.
    space show.
]

{ #category : #removing }
SnakeController >> removeNonFoodElementsFromGame [
    game childrenDo: [ :child |
        (foodElements includes: child) ifFalse: [ game removeChild: child ]
    ].
]

{ #category : #'as yet unclassified' }
SnakeController >> startScreen [
    | startSpace title startButton closeButton |
    
    startSpace := BlSpace new extent: (800@600); title:'Start Screen'.
    
    title := BlTextElement new.
    title
        text: ('JEU SNAKE' asRopedText fontSize: 50);
        position: (30@30).
    startSpace root addChild: title.
    
    "Force layout calculation"
    title layout.
    
    "Center the title horizontally and place it at a specific height"
    title position: (250 @ 40).
    
    "Create a start button"
    startButton := BlElement new.
    startButton
        size: (300@50);
        background: Color green;
        border: (BlBorder paint: Color black width: 2);
        when: BlClickEvent do: [  
            startSpace close.
            self openGame.
        ].
    
    startButton addChild: (BlTextElement new
        text: ('Commencer le jeu' asRopedText fontSize: 30);
        position: (40@10)).
    startSpace root addChild: startButton.
    startButton position: (230 @ 275).
    
    "Create a close button"
    closeButton := BlElement new.
    closeButton
        size: (300@50);
        background: Color red;
        border: (BlBorder paint: Color black width: 2);
        when: BlClickEvent do: [ startSpace close ].
    
    closeButton addChild: (BlTextElement new
        text: ('Fermer' asRopedText fontSize: 30);
        position: (110@10)).
    startSpace root addChild: closeButton.
    closeButton position: (230 @ 375).
    
    startSpace show.
]
