PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.gameboard = Gameboard()

    -- TODO: Add music
    -- gSounds['field-music']:setLooping(true)
    -- gSounds['field-music']:play()
end

function PlayState:enter()
	gStateStack:push(PlayerTurnState(
		self.gameboard.firstPlayerWizard,
		self.gameboard.secondPlayerWizard,
		self.gameboard.thirdPlayerWizard
	))
end

function PlayState:update(dt)
    self.gameboard:update(dt)
end

function PlayState:render()
    self.gameboard:render()
end