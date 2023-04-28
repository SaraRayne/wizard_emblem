PlayerTurnState = Class{__includes = BaseState}

function PlayerTurnState:init(firstWizard, secondWizard, thirdWizard)
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
			self.selectedWizard.mapX = self.boardHighlightX + 1
			self.selectedWizard.mapY = self.boardHighlightY + 1
			self.selectedWizard.x = (self.selectedWizard.mapX - 1) * TILE_SIZE
			self.selectedWizard.y = (self.selectedWizard.mapY - 1) * TILE_SIZE - self.selectedWizard.height / 2
			self.numWizardsMoved = self.numWizardsMoved + 1
			self.selectedWizard.canMove = false
			self.selectedWizard = nil
		elseif self:checkMovability(self.firstWizard) then
			self.selectedWizard = self.firstWizard
		elseif self:checkMovability(self.secondWizard) then
			self.selectedWizard = self.secondWizard
		elseif self:checkMovability(self.thirdWizard) then
			self.selectedWizard = self.thirdWizard
		end
	end
  
	if self.numWizardsMoved == 3 then
		print('Three wizards moved')
		gStateStack:pop()
		gStateStack:push(EnemyTurnState())
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
	print(currentX, currentY, newX, newY)
	if newX >= currentX - 2 and newX <= currentX + 2 and newY >= currentY - 2 and newY <= currentY + 2 then
		return true
	else
		return false
	end
end

function PlayerTurnState:render()
	-- draw box around current tile on battle grid
	love.graphics.setColor(255, 255, 255, 0.5)
	love.graphics.setLineWidth(1)
	love.graphics.rectangle('line', self.boardHighlightX * 16,
		self.boardHighlightY * 16, 16, 16, 1)
end