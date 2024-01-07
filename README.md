# Snake Game

Bienvenue dans le jeu Snake en PHARO !

Le jeu Snake est un jeu d'arcade classique où le joueur contrôle un serpent qui grandit en mangeant des fruits. Le but est de manger autant de fruits que possible sans que le serpent ne se heurte à lui-même ou aux murs de l'aire de jeu. À mesure que le serpent mange, il grandit et le jeu devient de plus en plus difficile.

## Instructions

## 1-installation de bloc 

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
```

## 2- Cloner le répertoire

Après avoir installé les dépendances, procédez au clonage du jeu

    Entrez les détails suivants du référentiel dans les référentiels git :
        Owner Name: mehdizse
        Project Name: jeu_snake
        Protocol: HTTPS 

Si l'état du référentiel indique « NOT LOADED », entrez dans le référentiel et cliquez avec le bouton droit sur chaque dossier pour sélectionner « Load ».

## 3- Lancer le jeu

```smalltalk
"Créez et démarrez le contrôleur Snake"
snake := SnakeController new.
snake startScreen.
```

## Contrôles

 Utilisez les touches fléchées Haut, Bas, Gauche et Droite pour changer la direction du serpent.
 
 Le déplacement du snake est automatique.

## Features

- Collision du snake avec le food.

- Collision du snake avec lui meme.

- Collision du snake avec les murs.

- Collision du snake avec un monstre (referencé en cercle orange) qui change de position tous les 10 secondes 

- Déplacement automatique.

- Utilisation des touches fleché pour le déplacement et interdication du déplacement vers autre sens par example si on va la droite on peut pas revenir en gauche.

## Ou trouver les tests ?

Les tests se situe dans **SnakeTest** et facilement executable.


## Gestion des événements et interaction utilisateur

**SnakeController** : Héritant de BlElement, cette classe est cruciale pour la gestion des événements, en particulier ceux déclenchés par les entrées au clavier. Il fonctionne en interaction avec la classe principale de Snake pour interpréter et répond aux actions des joueurs et aussi il contienne les classes principales .


## Représentation visuelle et rendu

**SnakeGame** : Cette classe est dédiée au gestion des segments du snake et son aspect visuel.

## Contributeurs

**Mehdi GHOMARI**

**Lynda BOUNEHAR**
