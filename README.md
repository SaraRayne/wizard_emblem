# **How to Play**

## Running and Starting the Game

1. Run the game by calling `love .` from the top level
2. From the title screen, press space to start the game
3. You'll be presented with a battle board with 3 wizards at the top of the screen, and 3 wizards at the bottom. The top wizards are under your control; the bottom are controlled by the computer. 
4. Each wizard has two bars over its head. The topmost red bar is a health bar. The bottom bar indicates the wizard's magic type (see more on magic types below).

## Player Turn

The game starts with the player's turn. Using the arrow keys, move around the board (you'll see an outline around the tile you're currently hovering over). Select the player you want to move by pressing `Enter` on the tile the sprite occupies, and you'll see all the tiles you can move to highlighted. Navigate with the arrow keys to a highlighted tile and press `Enter` to move there. Do the same for each other player sprite.

## Enemy Turn

Once you've moved all 3 of your wizards, it will be the enemy's turn. The enemy will move automatically towards your sprites.

## Combat

If an enemy wizard is within range (on a highlighted tile), you will be able to fight them by selecting the tile they occupy and pressing enter. Combat will automatically be initiated. 

## Magic Types

An important aspect of combat and winning the game is magic types. Each wizard will have a magic type: fire, water, ice, or lightning. The magic type is indicated by the bar color underneath the health bar:

Each type of magic has a strength and a weakness. Be sure to attack enemy wizards that are weak to your player wizard's magic type!

### Fire
- Represented by a light red bar
- Strong against: Ice
- Weak against: Water

### Water
- Represented by a deep blue bar
- Strong against: Fire
- Weak against: Ice, Lightning

### Ice
- Represented by a light blue bar
- Strong against: Water
- Weak against: Fire

### Lightning
- Represented by a yellow bar
- Strong against: Water
- Weak against: Nothing

## Winning the Game

To win the game, you must defeat all 3 enemy wizards. Use your wizards strategically to come out on top! If all your wizards are taken out first, you lose.


# Design and Code Description

## Basics

This project uses the same state stack format as the class's Pokemon project. I felt that this format fit my intended design very well, as the game mainly switches back and forth between a `PlayerTurnState` and `EnemyTurnState`, with other states tacked on here and there as necessary. 

## Files I Created

### Gameboard.lua

This file sets up the main battle grid. It creates the grid by rendering the tiles (simple grass texture found in `graphics/grass_tiles.png`). It also initializes all of the wizards for both players and enemies. `Gameboard` only renders wizards if they're alive (`isAlive` = true); this isn't the best method, but by the time I got around to coding death, it was easier just to add a boolean. I intended to remove them from their respective tables (`self.playerWizards` and `self.enemyWizards`), but that implementation proved a bit too complicated. 

### StartState.lua

This file isn't too different from the `StartState` file in Pokemon, with small changes to the starting dialogue and music. As an aside, choosing music was one of the most fun parts of this project. It started to feel like a real game once it had background music.

### PlayState.lua

The play state controls the transitions between `PlayerTurnState` and `EnemyTurnState`. In hindsight this might not be a completely necessary file (I could transition between turn states within the states themselves), but I do like having the logic controlled outside the turn states, which got very messy very quickly as I implemented more functionality. I also probably could have transitioned to EndGameState from here instead of inside each turn state. 

### PlayerTurnState.lua

This file controls everything that happens during a player's turn aside from combat (see `CombatState.lua`). It tracks which tile the player is hovering over (logic inspired by Match3), if a player wizard has been selected, and where to move them. Movement itself is controlled by a few different functions:
- `checkMovability` ensures the selected tile is occupied by a wizard and that wizard is able to move
- `checkBounds` ensures the selected tile to move the wizard to is within movement bounds (represented by the highlighted tiles on the gameboard)
- `checkCollision` determines if the selected tile to move to is occupied by any other wizard. This function is used in two different ways: if input table is enemy wizards and the tile is occupied, combat is initiated; if input table is player wizards and the tile is occupied, the selected wizard is moved to a tile nearby the selected tile (this will only happen if selected wizard is initiating combat with enemy wizard and needs to move to the nearest unoccupied tile).
- `findUnoccupiedTile` is called if a player wizard collides with an enemy; the player needs to move to one of the tiles surrounding the enemy, and this function determines which of those tiles is unoccupied, preventing multiple wizards from occupying the same tile. 

If all player wizards are dead, `EndGameState` will be called and the result will be a loss.

### EnemyTurnState.lua

This file controls enemy movement, which is initiated by a few functions (this code was some of the most fun to write):
- `moveEnemy` calls all the functions necessary for determining where to move the enemy and what to do if a collision occurs
- `findClosestPlayer` does some nifty math to determine which player wizard is closest to a given enemy wizard
- `findClosestTileToPlayer` takes the result from `findClosestPlayer` and uses that plus more nifty math to determine which tile is closest to that player
- `checkCollision` works the same as `checkCollision` in `PlayerTurnState` (but for enemies rather than players)
- `findUnoccupiedTile` works the same as `findUnoccupiedTile` in `PlayerTurnState` (but for enemies rather than players)

There are some design decisions in this code that are more ad hoc, for example the code inside `enter()` that initiates enemy movement. Initially I had the enemy movement code inside update, but that meant every enemy moved instantaneously. I nested all movement within `Timers` and in sequence so players could see each enemy move; I also added some delays to accomodate enemies in combat. It's a bit messy but it works well enough for this implementation. 

`findUnoccupiedTile` for both `PlayerTurnState` and `EnemyTurnState` is essentially a bug fix function. During testing I realized that when initiating combat, enemies ended up on the same tile due to the `findClosestTileToPlayer` function, and players could end up on the same tile due to the way I had implemented tile selection during combat. With more time I would have rewritten this to be more reusable and clean, but I was afraid of introducing new bugs after I got it working. 

### CombatState.lua

This file controls everything that happens when a player or enemy initiates combat. Combat occurs in a sequence, with the attacker striking first and the foe striking next, as long as the foe is still alive after they take damage. The main functions are `calculateDamage` and `checkForDeath`
- `calculateDamage` takes the stats for the attacker and foe and uses those to calculate how much damage should be dealt; the important factor here is the magic relationship between attacker and foe, which adds a multiplier to the damage dealt.
- `checkForDeath` determines if whoever just took damage has lost all their health; returns true if so

Both `PlayerTurnState` and `EnemyTurnState` use a boolean, inCombat, to "pause" progress while combat wraps up. This is another bug fix feature that I added when state issues started to pop up when an enemy hadn't finished combat yet but the rest of the code continued running. The result was that a state was popped off too early and the game became "stuck". I think I could have figured out a better way to prevent this, but the boolean worked well. 

### EndGameState.lua

This file is triggered when all player wizards are dead, or all enemy wizards are dead. It plays a nice little victory sound if the player has won, along with a victory message, and a sad you lost sound and message if the player has not won. It will also trigger the `PlayState` if the player chooses to play again. 

### StatBar.lua

The `StatBar` is used to display a bar over a wizard's head that will either be the wizard's remaining health, or a representation of their magic type (shown by color as described above).

### Wizard.lua

This file is used when a wizard is created. It keeps track of a wizard's stats and location, and it also includes a `takeDamage()` function that causes the wizard to blink when it takes damage as well as decreases health accordingly.

### wizard_defs.lua

This file contains the stats for the 4 different wizard types: fire, water, ice, and lightning. The stats include basics like health, attack, defense, etc as well as the multipliers used to calculate magic type-based damage and which color should be used in the `StatBar`. 

## Borrowed Files (from Pokemon)
- `Util.lua`
- `StateStack.lua`
- `BaseState.lua`
- `Panel.lua`
- `Textbox.lua`
- `DialogueState.lua`: minor modifications made
- `Tile.lua`