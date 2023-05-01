EndGameState = Class{__includes = BaseState}

function EndGameState:init(message)
  	self.message = DialogueState(message)
end

function EndGameState:enter()
    gStateStack:push(self.message)
end

function EndGameState:update(dt)
	if self.message.textbox.closed then
		gStateStack:pop()
		gStateStack:push(PlayState())
	end
end