# Snake Game

Bienvenue dans le jeu Snake en PHARO !

## Instructions


```smalltalk
"Installez la dépendance Bloc pour l'interface graphique"
[ Metacello new
	baseline: 'Bloc';
	repository: 'github://pharo-graphics/Bloc:dev-1.0/src';
	onConflictUseIncoming;
	ignoreImage;
	load ]
		on: MCMergeOrLoadWarning
		do: [ :warning | warning load ]

"Créez et démarrez le contrôleur Snake"
snake := SnakeController new.
snake startScreen.
```

## Contrôles

 Utilisez les touches fléchées Haut, Bas, Gauche et Droite pour changer la direction du serpent.
 
 Le déplacement du snake est automatique.

Amusez-vous bien !
