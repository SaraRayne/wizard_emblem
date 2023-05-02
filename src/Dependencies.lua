Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/Util'

require 'src/entity/wizard_defs'
require 'src/entity/Wizard'

require 'src/gui/Panel'
require 'src/gui/StatBar'
require 'src/gui/Textbox'

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/game/CombatState'
require 'src/states/game/DialogueState'
require 'src/states/game/EndGameState'
require 'src/states/game/EnemyTurnState'
require 'src/states/game/PlayState'
require 'src/states/game/PlayerTurnState'
require 'src/states/game/StartState'

require 'src/states/world/Gameboard'
require 'src/states/world/Tile'

gTextures = {
	['tiles'] = love.graphics.newImage('graphics/grass_tiles.png'),
	['wizards'] = love.graphics.newImage('graphics/tiny_sprites.png'),
}

gFrames = {
	['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
	['wizards'] = GenerateQuads(gTextures['wizards'], 16, 16)
}

gFonts = {
	['small'] = love.graphics.newFont('fonts/font.ttf', 8),
	['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
	['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

gSounds = {
  	['background-music'] = love.audio.newSource('sounds/background_music.mp3', 'static'),
	['damage'] = love.audio.newSource('sounds/damage.wav', 'static'),
	['game-over'] = love.audio.newSource('sounds/sad_game_over.wav', 'static'),
	['victory'] = love.audio.newSource('sounds/victory.wav', 'static')
}
