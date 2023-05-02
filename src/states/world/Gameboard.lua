Gameboard = Class{}

function Gameboard:init()
	self.tileHeight = 150
	self.tileWidth = 150
	self.tiles = {}

	-- Initialize player wizards
	self.firstPlayerWizard = Wizard {
		appearance = ENTITY_IDS['characters'][math.random(#ENTITY_IDS['characters'])],
        mapX = 5,
        mapY = 3,
        width = 16,
        height = 16,
		direction = 'down',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }
	self.secondPlayerWizard = Wizard {
		appearance = ENTITY_IDS['characters'][math.random(#ENTITY_IDS['characters'])],
        mapX = 12,
        mapY = 3,
        width = 16,
        height = 16,
		direction = 'down',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }
	self.thirdPlayerWizard = Wizard {
		appearance = ENTITY_IDS['characters'][math.random(#ENTITY_IDS['characters'])],
        mapX = 20,
        mapY = 3,
        width = 16,
        height = 16,
		direction = 'down',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }

	-- -- Initialize enemy wizards
	self.firstEnemyWizard = Wizard {
		appearance = ENTITY_IDS['characters'][math.random(#ENTITY_IDS['characters'])],
        mapX = 5,
        mapY = 13,
        width = 16,
        height = 16,
		direction = 'up',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }
	self.secondEnemyWizard = Wizard {
		appearance = ENTITY_IDS['characters'][math.random(#ENTITY_IDS['characters'])],
        mapX = 12,
        mapY = 13,
        width = 16,
        height = 16,
		direction = 'up',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }
	self.thirdEnemyWizard = Wizard {
		appearance = ENTITY_IDS['characters'][math.random(#ENTITY_IDS['characters'])],
        mapX = 20,
        mapY = 13,
        width = 16,
        height = 16,
		direction = 'up',
		stats = WIZARD_DEFS[WIZARD_IDS[math.random(#WIZARD_IDS)]]
    }

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