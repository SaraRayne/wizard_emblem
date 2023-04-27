PlayerTurnState = Class{__includes = BaseState}

function PlayerTurnState:init(firstWizard, secondWizard, thirdWizard)
	-- position in the battle grid which we're highlighting
	self.boardHighlightX = 0
	self.boardHighlightY = 0

	self.firstWizard = firstWizard
	self.firstWizard.canMove = true
	self.secondWizard = secondWizard
	self.secondWizard.canMove = true
	self.thirdWizard = thirdWizard
	self.thirdWizard.canMove = true

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

	-- TODO: watch for selection of player wizard (make sure wizard selected is player,
		-- move to position selected)
  
	if self.numWizardsMoved == 3 then
		gStateStack:pop()
		gStateStack:push(EnemyTurnState())
	end 
end

function PlayerTurnState:render()
	-- draw box around current tile on battle grid
	love.graphics.setColor(255, 255, 255, 0.5)
	love.graphics.setLineWidth(1)
	love.graphics.rectangle('line', self.boardHighlightX * 16,
		self.boardHighlightY * 16, 16, 16, 1)
end