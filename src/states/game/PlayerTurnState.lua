PlayerTurnState = Class{__includes = BaseState}

function PlayerTurnState:init(firstWizard, secondWizard, thirdWizard, playState)
	self.playState = playState
	self.enemies = self.playState.gameboard.enemyWizards
	self.inCombat = false
	
	-- position in the battle grid we're highlighting
	self.boardHighlightX = 0
	self.boardHighlightY = 0

	-- define wizards and allow movement by default
	self.firstWizard = firstWizard
	self.firstWizard.canMove = true
	self.secondWizard = secondWizard
	self.secondWizard.canMove = true
	self.thirdWizard = thirdWizard
	self.thirdWizard.canMove = true

	-- Initialize variables for tracking movement
	self.selectedWizard = nil
	self.numWizardsMoved = 0
end

function PlayerTurnState:enter()
	gStateStack:push(DialogueState("Player Turn"))
end

function PlayerTurnState:update(dt)
	aliveWizards = self:countAliveWizards({self.firstWizard, self.secondWizard, self.thirdWizard})
	if aliveWizards == 0 then
		gStateStack:pop()
		gStateStack:push(EndGameState("You have been defeated! Press Space to try again."))
	end

	-- move cursor around based on bounds of battle grid
	if love.keyboard.wasPressed('up') then
		self.boardHighlightY = math.max(0, self.boardHighlightY - 1)
	elseif love.keyboard.wasPressed('down') then
		self.boardHighlightY = math.min(VIRTUAL_HEIGHT, self.boardHighlightY + 1)
	elseif love.keyboard.wasPressed('left') then
		self.boardHighlightX = math.max(0, self.boardHighlightX - 1)
	elseif love.keyboard.wasPressed('right') then
		self.boardHighlightX = math.min(VIRTUAL_WIDTH - 16, self.boardHighlightX + 1)
	end

	-- Move wizards
	if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
		if self.selectedWizard ~= nil and self:checkBounds(self.selectedWizard.mapX, self.selectedWizard.mapY, self.boardHighlightX + 1, self.boardHighlightY + 1) then
			local collidedEnemy = self:checkCollision(self.boardHighlightX + 1, self.boardHighlightY + 1) 
			if collidedEnemy then
				-- Move to nearby tile
				self.selectedWizard.mapX = self.boardHighlightX + 1
				self.selectedWizard.mapY = self.boardHighlightY
				self.selectedWizard.x = (self.selectedWizard.mapX - 1) * TILE_SIZE
				self.selectedWizard.y = (self.selectedWizard.mapY - 1) * TILE_SIZE - self.selectedWizard.height / 2
				self.selectedWizard.canMove = false

				-- Initiate combat with enemy
				self.inCombat = true
				gStateStack:push(CombatState(self.selectedWizard, collidedEnemy, self))
				-- TODO: NEED TO WAIT FOR COMBAT TO FINISH, CAUSING STATE ISSUES
				self.numWizardsMoved = self.numWizardsMoved + 1
				self.selectedWizard = nil
			else
				-- Move wizard to selected location
				self.selectedWizard.mapX = self.boardHighlightX + 1
				self.selectedWizard.mapY = self.boardHighlightY + 1
				self.selectedWizard.x = (self.selectedWizard.mapX - 1) * TILE_SIZE
				self.selectedWizard.y = (self.selectedWizard.mapY - 1) * TILE_SIZE - self.selectedWizard.height / 2
				self.numWizardsMoved = self.numWizardsMoved + 1
				self.selectedWizard.canMove = false
				self.selectedWizard = nil
			end
		elseif self:checkMovability(self.firstWizard) then
			self.selectedWizard = self.firstWizard
		elseif self:checkMovability(self.secondWizard) then
			self.selectedWizard = self.secondWizard
		elseif self:checkMovability(self.thirdWizard) then
			self.selectedWizard = self.thirdWizard
		end
	end

	self.firstWizard:update()
	self.secondWizard:update()
	self.thirdWizard:update()
  
	if self.numWizardsMoved == aliveWizards and aliveWizards ~= 0 and self.inCombat == false then
		print('Enemy Turn')
		gStateStack:pop()
		self.playState.turn = 'enemy'
	end
end

function PlayerTurnState:checkMovability(wizard)
	if self.boardHighlightX + 1 == wizard.mapX and self.boardHighlightY + 1 == wizard.mapY and wizard.canMove then
		return true
	else
		return false
	end
end

function PlayerTurnState:checkBounds(currentX, currentY, newX, newY)
	if newX >= currentX - 2 and newX <= currentX + 2 and newY >= currentY - 2 and newY <= currentY + 2 then
		return true
	else
		return false
	end
end

function PlayerTurnState:checkCollision(x, y)
	for i, enemy in pairs(self.enemies) do
		if x == enemy.mapX and y == enemy.mapY then
			return enemy
		end
	end
	return nil
end

function PlayerTurnState:countAliveWizards(playerWizards)
	local aliveCount = 0

	for i, wizard in pairs(playerWizards) do
		if wizard.isAlive then
			aliveCount = aliveCount + 1
		end
	end

	return aliveCount
end

function PlayerTurnState:render()
	-- draw box around current tile on battle grid
	love.graphics.setColor(255, 255, 255, 0.5)
	love.graphics.setLineWidth(1)
	love.graphics.rectangle('line', self.boardHighlightX * 16,
		self.boardHighlightY * 16, 16, 16, 1)

	-- highlight tiles player can move to
	if self.selectedWizard then
		local allowedX = {self.selectedWizard.mapX, math.min(self.selectedWizard.mapX + 1, VIRTUAL_WIDTH - 16), math.min(self.selectedWizard.mapX + 2, VIRTUAL_WIDTH - 16), math.max(0, self.selectedWizard.mapX - 1), math.max(0, self.selectedWizard.mapX - 2)}
		local allowedY = {self.selectedWizard.mapY, math.min(self.selectedWizard.mapY + 1, VIRTUAL_HEIGHT), math.min(self.selectedWizard.mapY + 2, VIRTUAL_HEIGHT), math.max(0, self.selectedWizard.mapY - 1), math.max(0, self.selectedWizard.mapY - 2)}
		for i, xValue in pairs(allowedX) do
			for k, yValue in pairs(allowedY) do
				love.graphics.setColor(255, 255, 255, 0.15)
				love.graphics.rectangle("fill", (xValue - 1) * 16, (yValue - 1) * 16, 16, 16, 1)
			end
		end
	end
end