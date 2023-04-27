PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.gameboard = Gameboard()

    -- TODO: Add music
    -- gSounds['field-music']:setLooping(true)
    -- gSounds['field-music']:play()

    	-- Initialize player wizards
	self.firstPlayerWizard = Wizard {
        animations = ENTITY_DEFS['player'].animations,
        mapX = 5,
        mapY = 3,
        width = 16,
        height = 16,
		direction = 'down'
    }
	self.secondPlayerWizard = Wizard {
        animations = ENTITY_DEFS['player'].animations,
        mapX = 12,
        mapY = 3,
        width = 16,
        height = 16,
		direction = 'down'
    }
	self.thirdPlayerWizard = Wizard {
        animations = ENTITY_DEFS['player'].animations,
        mapX = 20,
        mapY = 3,
        width = 16,
        height = 16,
		direction = 'down'
    }

	self.firstPlayerWizard.stateMachine = StateMachine {
		-- ['walk'] = function() return PlayerWalkState(self.firstPlayerWizard, self) end,
		['idle'] = function() return WizardIdleState(self.firstPlayerWizard, self) end
	}
    self.firstPlayerWizard.stateMachine:change('idle')

	self.secondPlayerWizard.stateMachine = StateMachine {
		-- ['walk'] = function() return PlayerWalkState(self.firstPlayerWizard, self) end,
		['idle'] = function() return WizardIdleState(self.secondPlayerWizard, self) end
	}
    self.secondPlayerWizard.stateMachine:change('idle')

	self.thirdPlayerWizard.stateMachine = StateMachine {
		-- ['walk'] = function() return PlayerWalkState(self.firstPlayerWizard, self) end,
		['idle'] = function() return WizardIdleState(self.thirdPlayerWizard, self) end
	}
    self.thirdPlayerWizard.stateMachine:change('idle')

	-- Initialize enemy wizards
	self.firstEnemyWizard = Wizard {
        animations = ENTITY_DEFS['enemy'].animations,
        mapX = 5,
        mapY = 13,
        width = 32,
        height = 48,
		direction = 'up'
    }
	self.secondEnemyWizard = Wizard {
        animations = ENTITY_DEFS['enemy'].animations,
        mapX = 12,
        mapY = 13,
        width = 32,
        height = 48,
		direction = 'up'
    }
	self.thirdEnemyWizard = Wizard {
        animations = ENTITY_DEFS['enemy'].animations,
        mapX = 20,
        mapY = 13,
        width = 32,
        height = 48,
		direction = 'up'
    }

	self.firstEnemyWizard.stateMachine = StateMachine {
		-- ['walk'] = function() return PlayerWalkState(self.firstPlayerWizard, self) end,
		['idle'] = function() return WizardIdleState(self.firstEnemyWizard, self) end
	}
    self.firstEnemyWizard.stateMachine:change('idle')

	self.secondEnemyWizard.stateMachine = StateMachine {
		-- ['walk'] = function() return PlayerWalkState(self.firstPlayerWizard, self) end,
		['idle'] = function() return WizardIdleState(self.secondEnemyWizard, self) end
	}
    self.secondEnemyWizard.stateMachine:change('idle')

	self.thirdEnemyWizard.stateMachine = StateMachine {
		-- ['walk'] = function() return PlayerWalkState(self.firstPlayerWizard, self) end,
		['idle'] = function() return WizardIdleState(self.thirdEnemyWizard, self) end
	}
	self.thirdEnemyWizard.stateMachine:change('idle')
end

function PlayState:enter()
	gStateStack:push(PlayerTurnState(
		self.firstPlayerWizard,
		self.secondPlayerWizard,
		self.thirdPlayerWizard
	))
end

function PlayState:update(dt)
    self.gameboard:update(dt)
	self.firstPlayerWizard:update(dt)
	self.secondPlayerWizard:update(dt)
	self.thirdPlayerWizard:update(dt)

	self.firstEnemyWizard:update(dt)
	self.secondEnemyWizard:update(dt)
	self.thirdEnemyWizard:update(dt)
end

function PlayState:render()
    self.gameboard:render()

	self.firstPlayerWizard:render()
	self.secondPlayerWizard:render()
	self.thirdPlayerWizard:render()

	self.firstEnemyWizard:render()
	self.secondEnemyWizard:render()
	self.thirdEnemyWizard:render()
end