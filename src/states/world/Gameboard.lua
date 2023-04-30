Gameboard = Class{}

function Gameboard:init()
	self.tileHeight = 150
	self.tileWidth = 150
	self.tiles = {}

	-- Initialize player wizards
	self.firstPlayerWizard = Wizard {
        animations = ENTITY_DEFS['player'].animations,
        mapX = 5,
        mapY = 3,
        width = 16,
        height = 16,
		direction = 'down',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }
	self.secondPlayerWizard = Wizard {
        animations = ENTITY_DEFS['player'].animations,
        mapX = 12,
        mapY = 3,
        width = 16,
        height = 16,
		direction = 'down',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }
	self.thirdPlayerWizard = Wizard {
        animations = ENTITY_DEFS['player'].animations,
        mapX = 20,
        mapY = 3,
        width = 16,
        height = 16,
		direction = 'down',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }

	self.firstPlayerWizard.stateMachine = StateMachine {
		['idle'] = function() return WizardIdleState(self.firstPlayerWizard, self) end
	}
    self.firstPlayerWizard.stateMachine:change('idle')

	self.secondPlayerWizard.stateMachine = StateMachine {
		['idle'] = function() return WizardIdleState(self.secondPlayerWizard, self) end
	}
    self.secondPlayerWizard.stateMachine:change('idle')

	self.thirdPlayerWizard.stateMachine = StateMachine {
		['idle'] = function() return WizardIdleState(self.thirdPlayerWizard, self) end
	}
    self.thirdPlayerWizard.stateMachine:change('idle')

	-- Initialize enemy wizards
	self.firstEnemyWizard = Wizard {
        animations = ENTITY_DEFS['enemy'].animations,
        mapX = 5,
        mapY = 13,
        width = 16,
        height = 16,
		direction = 'up',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }
	self.secondEnemyWizard = Wizard {
        animations = ENTITY_DEFS['enemy'].animations,
        mapX = 12,
        mapY = 13,
        width = 16,
        height = 16,
		direction = 'up',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }
	self.thirdEnemyWizard = Wizard {
        animations = ENTITY_DEFS['enemy'].animations,
        mapX = 20,
        mapY = 13,
        width = 16,
        height = 16,
		direction = 'up',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }

	self.firstEnemyWizard.stateMachine = StateMachine {
		['idle'] = function() return WizardIdleState(self.firstEnemyWizard, self) end
	}
    self.firstEnemyWizard.stateMachine:change('idle')

	self.secondEnemyWizard.stateMachine = StateMachine {
		['idle'] = function() return WizardIdleState(self.secondEnemyWizard, self) end
	}
    self.secondEnemyWizard.stateMachine:change('idle')

	self.thirdEnemyWizard.stateMachine = StateMachine {
		['idle'] = function() return WizardIdleState(self.thirdEnemyWizard, self) end
	}
	self.thirdEnemyWizard.stateMachine:change('idle')

	-- Add all wizards to table
	self.playerWizards = {
		self.firstPlayerWizard,
		self.secondPlayerWizard,
		self.thirdPlayerWizard
	}

	self.enemyWizards = {
		self.firstEnemyWizard,
		self.secondEnemyWizard,
		self.thirdEnemyWizard
	}

	self:createGrid()
end

function Gameboard:createGrid()
	-- TODO: put correct field tiles on board
	for y = 1, self.tileHeight do
		table.insert(self.tiles, {})

		for x = 1, self.tileWidth do
			local id = TILE_IDS['grass'][math.random(#TILE_IDS['grass'])]

			table.insert(self.tiles[y], Tile(x, y, id))
		end
	end
end

function Gameboard:update(dt)
	self.firstPlayerWizard:update(dt)
	self.secondPlayerWizard:update(dt)
	self.thirdPlayerWizard:update(dt)

	self.firstEnemyWizard:update(dt)
	self.secondEnemyWizard:update(dt)
	self.thirdEnemyWizard:update(dt)
end

function Gameboard:render()
	for y = 1, self.tileHeight do
        for x = 1, self.tileHeight do
            self.tiles[y][x]:render()
        end
    end

	for i, wizard in pairs(self.playerWizards) do
		if wizard.isAlive then
			wizard:render()
		end
	end

	for i, wizard in pairs(self.enemyWizards) do
		if wizard.isAlive then
			wizard:render()
		end
	end
end