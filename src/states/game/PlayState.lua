PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.gameboard = Gameboard()

		self.turn = 'player'

    -- TODO: Add music
    -- gSounds['field-music']:setLooping(true)
    -- gSounds['field-music']:play()
end

function PlayState:update(dt)
    self.gameboard:update(dt)

	if self.turn == 'player' then
		gStateStack:push(PlayerTurnState(
			self.gameboard.firstPlayerWizard,
			self.gameboard.secondPlayerWizard,
			self.gameboard.thirdPlayerWizard,
			self
		))
	end

	if self.turn == 'enemy' then
		gStateStack:push(EnemyTurnState(
			self.gameboard.firstEnemyWizard,
			self.gameboard.secondEnemyWizard,
			self.gameboard.thirdEnemyWizard,
			self
		))
	end
end

function PlayState:render()
    self.gameboard:render()
end