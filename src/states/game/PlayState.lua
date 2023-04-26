PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.gameboard = Gameboard()

	-- position in the grid which we're highlighting
	self.boardHighlightX = 0
	self.boardHighlightY = 0
	
	-- timer used to switch the highlight rect's color
	self.rectHighlighted = false

    -- TODO: Add music
    -- gSounds['field-music']:setLooping(true)
    -- gSounds['field-music']:play()

    -- self.dialogueOpened = false
end

function PlayState:update(dt)
	-- move cursor around based on bounds of grid, playing sounds
	if love.keyboard.wasPressed('up') then
		self.boardHighlightY = math.max(0, self.boardHighlightY - 1)
	elseif love.keyboard.wasPressed('down') then
		self.boardHighlightY = math.min(VIRTUAL_HEIGHT, self.boardHighlightY + 1)
	elseif love.keyboard.wasPressed('left') then
		self.boardHighlightX = math.max(0, self.boardHighlightX - 1)
	elseif love.keyboard.wasPressed('right') then
		self.boardHighlightX = math.min(VIRTUAL_WIDTH - 16, self.boardHighlightX + 1)
	end

    self.gameboard:update(dt)
end

function PlayState:render()
    self.gameboard:render()

	love.graphics.setColor(255, 255, 255, 0.5)
	love.graphics.setLineWidth(1)
	love.graphics.rectangle('line', self.boardHighlightX * 16,
		self.boardHighlightY * 16, 16, 16, 1)
end