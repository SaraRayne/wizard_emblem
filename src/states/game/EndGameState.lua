EndGameState = Class{__includes = BaseState}

function EndGameState:init(message)
  self.message = message
end

function EndGameState:enter()
    gStateStack:push(DialogueState(self.message))
end

function EndGameState:update(dt)
    -- TODO: if pressed enter, switch to start state (pop this state)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(StartState())
    end
end

function EndGameState:render()

end