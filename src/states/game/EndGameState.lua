EndGameState = Class{__includes = BaseState}

function EndGameState:init(message, victory)
  	self.message = DialogueState(message)
	self.victory = victory
end

function EndGameState:enter()
	if self.victory then
		gSounds['victory']:play()
	else
		gSounds['game-over']:play()
	end
    gStateStack:push(self.message)
end

function EndGameState:update(dt)
	if self.message.textbox.closed then
		gStateStack:pop()
		gStateStack:push(PlayState())
	end
end